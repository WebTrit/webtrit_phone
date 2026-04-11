package com.webtrit.signaling_service

import android.content.Context
import android.util.Log
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.Worker
import androidx.work.WorkerParameters
import java.util.concurrent.TimeUnit

/// WorkManager worker that restarts [SignalingForegroundService] after it is killed.
///
/// Enqueued by [SignalingForegroundService.onDestroy] (15 s delay) and
/// [SignalingForegroundService.onTaskRemoved] (1 s delay) when in persistent mode.
/// The [ExistingWorkPolicy.REPLACE] policy resets the timer if both triggers fire
/// close together, preventing duplicate restarts.
///
/// [Result.retry] is returned on [Exception] so WorkManager retries with
/// exponential back-off. On Android 12+ this handles the case where
/// [startForegroundService] throws [ForegroundServiceStartNotAllowedException]
/// because the process has left the BFGS window — the next retry happens when the
/// user opens the app or another foreground service becomes active.
class SignalingRestartWorker(
    context: Context,
    workerParams: WorkerParameters,
) : Worker(context, workerParams) {

    override fun doWork(): Result = try {
        if (!SignalingForegroundService.isRunning &&
            !StorageDelegate.isPushBound(applicationContext) &&
            StorageDelegate.getCoreUrl(applicationContext).isNotEmpty() &&
            StorageDelegate.getCallbackDispatcher(applicationContext) != 0L
        ) {
            Log.w(TAG, "SignalingRestartWorker: restarting persistent FGS")
            SignalingForegroundService.start(applicationContext)
        }
        Result.success()
    } catch (e: Exception) {
        Log.e(TAG, "Failed to restart FGS: $e")
        Result.retry()
    }

    companion object {
        private const val TAG = "SignalingRestartWorker"
        private const val WORK_TAG = "signaling_fgs_restart"

        fun enqueue(context: Context, delayMillis: Long = 15_000) {
            val request = OneTimeWorkRequestBuilder<SignalingRestartWorker>()
                .addTag(WORK_TAG)
                .setInitialDelay(delayMillis, TimeUnit.MILLISECONDS)
                .build()
            WorkManager.getInstance(context)
                .enqueueUniqueWork(WORK_TAG, ExistingWorkPolicy.REPLACE, request)
        }

        fun remove(context: Context) {
            WorkManager.getInstance(context).cancelAllWorkByTag(WORK_TAG)
        }
    }
}
