
# Beschrijving van de PoC's


Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
### Android grafieken

* **hypothese:**  
Hoe kan ik in android het best en netst grafieken maken en tonen?

* **testopzet:**  
> Ik wil meerdere methoden opzoeken en uitzoeken welke de beste is.
> Methoden/bronnen:
> 1. [MPAndroidChart](https://github.com/PhilJay/MPAndroidChart)
> 2. [AChartEngine](https://github.com/ddanny/achartengine)
> 3. [WilliamChart](https://github.com/diogobernardino/WilliamChart)
> 4. [HelloCharts android](https://github.com/lecho/hellocharts-android)
> 5. [Androidplot](https://github.com/halfhp/androidplot)

* **resultaat:** 
1. [MPAndroidChart](https://github.com/PhilJay/MPAndroidChart)
> #### Pluspunten:
> * Groot aantal verschillende grafieken:
>> 1. Lijndiagram (kan met meerdere lijnen)
>> 2. Staafdiagram (verticaal, horizontaal, gestapeld en gegroepeerd)
>> 3. Cirkeldiagram
>> 4. Spreidingsdiagram
>> 5. Kandelaar grafiek (voor financiele data)
>> 6. Radardiagram
>> 7. Bubbeldiagram
> * Automatische schaling
> * Zoom en sleep functionaliteiten
> * Voorbeeld project
> * Beschikbaar als maven en gradle dependency 
> * Schijnt ook beschikbaar te zijn voor ios en xamarin
> #### Minpunten:
> * Werkt niet goed met realtime data (veranderingen)
> #### Eigen mening:
> Ik heb deze zelf getest, doordat dit project een voorbeeld project heeft met heel veel verschillende grafieken is het heel eenvoudig om er zelf mee aan de slag te gaan door de gewenste grafiek in het voorbeeld projcet te zoeken en deze te kopieren (of hiervan afkijken). Daarnaast is de documentatie redelijk uitgebreid en duidelijk. Als ik grafieken nodig zou hebben in mijn android app zou ik deze library zonder problemen kunnen gebruiken. 
```java
        LineChart chart = findViewById(R.id.LineChart);
        List<Entry> entries = new ArrayList<>();
        Random r = new Random();
        for(int i = 0; i < 25; i++) {
            entries.add(new Entry(i, r.nextInt(100)));
        }
        LineDataSet lineDataSet = new LineDataSet(entries, "graph");
        LineData lineData = new LineData(lineDataSet);
        chart.setData(lineData);
        chart.invalidate();
    }
```
> Bovenstaande code is alles om de meest simpele line chart te tonen met random waarden.
2. [AChartEngine](https://github.com/ddanny/achartengine)
> #### Pluspunten:
> * Groot aantal verschillende grafieken:
>> 1. Lijndiagram (kan met meerdere lijnen)
>> 2. Gestapelde diagram
>> 3. Tijdsgrafiek
>> 4. Bubbeldiagram
>> 5. Donutdiagram
>> 6. Gekombineerd diagram
> * Automatische schaling
> * Zoom en sleep functionaliteiten
> * Bischikbaar als gradle dependency
> #### Minpunten:
> * Geen documentatie
> #### Eigen mening:
> Deze graph heb ik ook getest. Deze library is out of the box in de meest uitgeklede variant wel een stuk minder mooi en zit anders in elkaar doordat de view in de code wordt toegevoegd in plaats van de android layout designer. Met onderstaande code kon ik dit mogelijk maken. Dit project heeft eigenlijk geen documentatie, er zijn wel een aantal handleidingen in hoe het te gebruiken is.
```java
        XYSeries series = new XYSeries("London Temperature hourly");
        for(int i = 0; i < 25; i++) {
            series.add(i, r.nextInt(35)); //random temperatuur tussen 0 en 35
        }
        XYSeriesRenderer renderer = new XYSeriesRenderer();

        XYMultipleSeriesRenderer mRenderer = new XYMultipleSeriesRenderer();
        mRenderer.addSeriesRenderer(renderer);
        
        XYMultipleSeriesDataset xymsd = new XYMultipleSeriesDataset();
        xymsd.addSeries(series);
        GraphicalView chartView = ChartFactory.getLineChartView(this, xymsd, mRenderer);
        ConstraintLayout chartLyt = findViewById(R.id.chart);
        chartLyt.addView(chartView,0);
``` 
3. [WilliamChart](https://github.com/diogobernardino/WilliamChart)
> #### Pluspunten:
> * Aantal verschillende grafieken:
>> 1. Lijndiagram
>> 2. Staafdiagram (ook horizontaal en gestapeld.)
> * Redelijk fancy animaties
> * Minimalistisch design.
> #### Minpunten:
> * Praktisch geen documentatie
> * Niet veel keuze met grafieken
> * Geen voorbeelden/ tutorials
> #### Eigen mening:
> Deze library ziet er mooi en minimalistisch uit maar als je ook maar iets meer wilt als een lijn of staafdiagram dan kan dat niet. Ik raad deze library dus af, hij is te minimalistisch. 
4. [HelloCharts android](https://github.com/lecho/hellocharts-android)
> #### Pluspunten:
> * Aantal verschillende grafieken:
>> 1. Lijndiagram (kan met meerdere lijnen)
>> 2. Gestapelde diagram
>> 3. Circeldiagram
>> 4. Bubbeldiagram
>> 6. Gekombineerd diagram
> * Automatische schaling
> * Zoom en sleep functionaliteitenLine chart(cubic lines, filled lines, scattered points)
> * Animaties
> #### Minpunten:
> * De meest minimalistische weergave is alleen een lijn. 
> * Niet heel veel keuze in grafieken
> #### Eigen mening:
> Deze library lijkt in gebruik redelijk veel op de MPAndroidChart, maar dan met minder diagrammen en wat minder uitgebreid in de meest simpele versie. De documentatie op deze library is vrij beperkt, er staat wel een simpele uitleg op de hoofdpagina van het github project. Met onderstaande code kan dit gerealiseerd worden. 
```java
       List<PointValue> values = new ArrayList<PointValue>();
        for(int i = 0; i < 25; i++) {
            values.add(new PointValue(i, r.nextInt(100)));
        }
        Line line = new Line(values).setColor(Color.BLUE).setCubic(true);
        List<Line> lines = new ArrayList<Line>();
        line.setValues(values);

        lines.add(line);
        LineChartData data = new LineChartData();
        data.setLines(lines);

        LineChartView helloChart = findViewById(R.id.chart);
        helloChart.setLineChartData(data);
```
> Dit is een vrij simpele settup waarbij 25 verschillende random punten getoond worden met een kronkelende lijn ertussen. Dit is redelijk vergelijkbaar met MPAndroidChart. Voor simpele grafieken is dit niet moeilijk om te gebruiken.
5. [Androidplot](https://github.com/halfhp/androidplot) 
> #### Pluspunten:
> * Groot aantal verschillende grafieken:
>> 1. Lijndiagram
>> 2. Staafdiagram
>> 3. Puntdiagram
>> 4. Cirkeldiagram
>> 5. Stappendiagram
>> 6. Kandelaardiagram
>> 7. Bubbeldiagram
> * Automatische schaling
> * Zoom en sleep functionaliteitenLine chart(cubic lines, filled lines, scattered points)
> * Animaties
> * Demo apps
> * Documentatie
> #### Minpunten:
> * Ziet er ouderwets uit
> #### Eigen mening:
> Deze library was iets lastiger om uit te vogelen, er zat in de tutorial veel meer 'troep' dan nodig was. Maar voor de meest basis versie heb ik onderstaande code gebruikt.
```java
    XYPlot plot = (XYPlot) findViewById(R.id.plot);

    List<Number> series1Numbers = new ArrayList<Number>();
    for(int i = 0; i < 25; i++) {
        series1Numbers.add((float) r.nextInt(100));

    SimpleXYSeries series1 = new SimpleXYSeries(series1Numbers, SimpleXYSeries.ArrayFormat.Y_VALS_ONLY, "Series1");

    LineAndPointFormatter series1Format = new LineAndPointFormatter();
    plot.addSeries(series1, series1Format);

    plot.getGraph();
```
> Om te starten is deze library een beetje onoverzichtelijk (de documentatie ervan) maar na wat onnodige 'troep' weghalen wordt het allemaal wat overzichtelijker en logischer, wat me wel een beetje tegenstaat is het feit dat de achtergrond gelijk zwart wordt en de ruimte onder de lijn gevuld wordt. 

### Conclusie
> Ik vind de eerste library na dit 'onderzoek' de meest bruikbare, het makkelijkst te implementeren met de meeste opties.
