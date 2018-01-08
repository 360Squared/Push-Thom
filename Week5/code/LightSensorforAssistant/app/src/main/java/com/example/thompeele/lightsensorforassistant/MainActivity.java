package com.example.thompeele.lightsensorforassistant;

import android.app.assist.AssistContent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.net.Uri;
import android.service.voice.AlwaysOnHotwordDetector;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private TextView textLight;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textLight = (TextView)findViewById(R.id.light_intensity);

        SensorManager mySensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
        Sensor LightSensor = mySensorManager.getDefaultSensor(Sensor.TYPE_LIGHT);
        mySensorManager.registerListener(LightSensorListener, LightSensor, SensorManager.SENSOR_DELAY_NORMAL);

//        AlwaysOnHotwordDetector alwaysOnHotwordDetector = new AlwaysOnHotwordDetector();

    }

    private final SensorEventListener LightSensorListener = new SensorEventListener() {

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
            // TODO Auto-generated method stub
        }

        @Override
        public void onSensorChanged(SensorEvent event) {
            if (event.sensor.getType() == Sensor.TYPE_LIGHT) {
//                Log.d("Light", "onSensorChanged: light value: " + event.values[0]);
                textLight.setText(String.valueOf(event.values[0]));
            }
        }
    };

    @Override
    public Uri onProvideReferrer() {
        return new Uri.Builder().scheme("www.tweaker.net").build();
    }
    @Override
    public void onProvideAssistData(Bundle data) {
        Log.d("light intensity", "onProvideAssistContent: aosuhehuaseohushauhuelnehusaheshaosuhdaesuheauheaushusnahuesahsaeohuaosuhasuhasahuseahoues1");
        data.putStringArrayList("light intensity",new ArrayList<String>(Integer.parseInt("1")));
        super.onProvideAssistData(data);
    }

    @Override
    public void onProvideAssistContent(AssistContent assistContent) {
        Log.d("light intensity", "onProvideAssistContent: aosuhehuaseohushauhuelnehusaheshaosuhdaesuheauheaushusnahuesahsaeohuaosuhasuhasahuseahoues2");
        String structuredJson = null;
        try {
            structuredJson = new JSONObject()
                    .put("@type", "LightIntensity")
                    .put("@id", "www.tweaker.net")
                    .put("name", "light intensity")
                    .toString();
        } catch (JSONException e) {
            e.printStackTrace();
        }

        assistContent.setStructuredData(structuredJson);
        Uri uri = new Uri.Builder().scheme("www.tweaker.net").build();
        assistContent.setWebUri(uri);
        super.onProvideAssistContent(assistContent);
        Log.d("snoaeuhtasnouhaesot", "onProvideAssistContent: stufff");

    }
}
