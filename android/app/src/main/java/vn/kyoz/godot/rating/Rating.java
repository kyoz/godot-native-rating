package vn.kyoz.godot.rating;

import android.os.Build;
import android.util.ArraySet;
import android.util.Log;

import androidx.annotation.NonNull;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.tasks.Task;
import com.google.android.play.core.review.ReviewInfo;
import com.google.android.play.core.review.ReviewManager;
import com.google.android.play.core.review.ReviewManagerFactory;

import org.godotengine.godot.Godot;
import org.godotengine.godot.plugin.GodotPlugin;
import org.godotengine.godot.plugin.SignalInfo;
import org.godotengine.godot.plugin.UsedByGodot;

import java.util.Set;

public class Rating extends GodotPlugin {
    private static final String TAG = "GodotRating";

    public Rating(Godot godot) {
        super(godot);
    }

    @NonNull
    @Override
    public String getPluginName() {
        return getClass().getSimpleName();
    }


    @NonNull
    @Override
    public Set<SignalInfo> getPluginSignals() {
        Set<SignalInfo> signals = new ArraySet<>();

        signals.add(new SignalInfo(Signals.ERROR, String. class));
        signals.add(new SignalInfo(Signals.COMPLETED));

        return signals;
    }

    @UsedByGodot
    public void show() {
        GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();
        int status = googleApiAvailability.isGooglePlayServicesAvailable(getActivity());

        if (status != ConnectionResult.SUCCESS) {
            emitSignal(Signals.ERROR, Errors.ERROR_GOOGLE_PLAY_UNAVAILABLE);
            Log.e(TAG, Errors.ERROR_GOOGLE_PLAY_UNAVAILABLE);
            return;
        }

        ReviewManager manager = ReviewManagerFactory.create(getActivity());
        Task<ReviewInfo> request = manager.requestReviewFlow();

        request.addOnCompleteListener(task -> {
            if (task.isSuccessful()) {
                ReviewInfo reviewInfo = task.getResult();
                Task<Void> flow = manager.launchReviewFlow(getActivity(), reviewInfo);

                flow.addOnCompleteListener(reviewFlow -> {
                    // The flow has finished. The API does not indicate whether the user
                    // reviewed or not, or even whether the review dialog was shown. Thus, no
                    // matter the result, we continue our app flow.
                    emitSignal(Signals.COMPLETED);
                });

            } else {
                emitSignal(Errors.ERROR_UNKNOWN);
            }
        });
    }
}
