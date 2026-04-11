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
/// On Android 12+ (API 31+), [startForegroundService] can throw
/// [ForegroundServiceStartNotAllowedException] when the process has left the BFGS
/// window. This is a transient condition — [Result.retry] is returned so WorkManager
/// retries with exponential back-off until the process re-enters foreground.
/// All other exceptions indicate permanent failures and return [Result.failure]
/// to avoid unbounded retry loops.
class SignalingRestartWorker(
    context: Context,
    workerParams: WorkerParameters,
) : Worker(context, workerParams) {

    override fun doWork(): Result = try {
        if (!SignalingForegroundService.isRunning &&
            !StorageDelegate.isPushBound(applicationContext) &&
            StorageDelegate.getCoreUrl(applicationContext).isNotEmpty() &&
            StorageDelegate.getTenantId(applicationContext).isNotEmpty() &&
            StorageDelegate.getToken(applicationContext).isNotEmpty() &&
            StorageDelegate.getCallbackDispatcher(applicationContext) != 0L
        ) {
            Log.w(TAG, "SignalingRestartWorker: restarting persistent FGS")
            SignalingForegroundService.start(applicationContext)
        }
        Result.success()
    } catch (e: Exception) {
        // ForegroundServiceStartNotAllowedException is expected on Android 12+ when the process
        // has left the BFGS window. Log at warning level (transient) and schedule a retry.
        // All other exceptions are permanent failures -- log at error level and stop retrying.
        if (e.javaClass.name == "android.app.ForegroundServiceStartNotAllowedException") {
            Log.w(TAG, "Cannot restart FGS: process not in BFGS state, will retry", e)
            Result.retry()
        } else {
            Log.e(TAG, "Failed to restart FGS (permanent)", e)
            Result.failure()
        }
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
            WorkManager.getInstance(context).cancelUniqueWork(WORK_TAG)
        }
    }
}
