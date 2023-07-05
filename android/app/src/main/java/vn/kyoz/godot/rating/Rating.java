package vn.kyoz.godot.rating;

import android.util.ArraySet;

import androidx.annotation.NonNull;

import org.godotengine.godot.Godot;
import org.godotengine.godot.plugin.GodotPlugin;
import org.godotengine.godot.plugin.SignalInfo;

import java.util.Arrays;
import java.util.List;
import java.util.Set;

public class Rating extends GodotPlugin {

    final private SignalInfo finishedSignal = new SignalInfo("finished");

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
    public List<String> getPluginMethods() {
        return Arrays.asList("request");
    }

    @NonNull
    @Override
    public Set<SignalInfo> getPluginSignals() {
        Set<SignalInfo> signals = new ArraySet<>();

        signals.add(new SignalInfo("finished", String.class));

        return super.getPluginSignals();
    }

    public void request() {
        emitSignal("finished", "CMM");
    }
}
