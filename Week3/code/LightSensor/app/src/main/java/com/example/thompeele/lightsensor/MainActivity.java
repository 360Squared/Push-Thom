package com.example.thompeele.lightsensor;

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    private TextView textLight;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textLight = (TextView)findViewById(R.id.LIGHT_reading);

        SensorManager mySensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
        Sensor LightSensor = mySensorManager.getDefaultSensor(Sensor.TYPE_LIGHT);
        mySensorManager.registerListener(LightSensorListener, LightSensor, SensorManager.SENSOR_DELAY_NORMAL);

    }

    private final SensorEventListener LightSensorListener = new SensorEventListener() {

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
            // TODO Auto-generated method stub
        }

        @Override
        public void onSensorChanged(SensorEvent event) {
            if (event.sensor.getType() == Sensor.TYPE_LIGHT) {
                Log.d("Light", "onSensorChanged: light value: " + event.values[0]);
                textLight.setText("light value: " + event.values[0]);
            }
        }
    };
}
