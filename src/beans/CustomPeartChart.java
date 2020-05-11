package beans;

public class CustomPeartChart {
public Integer key;   // key 
public String text;   //shop
public String earlyStart;  //min
public String length; //max
public String earlyFinish; //std dev
public String lateStart;  // avg time
public String slack; // total prod
public String lateFinish;  // work in progress
public boolean critical;
public CustomPeartChart()
{
	
}

public CustomPeartChart(Integer key, String text, String earlyStart, String length, String earlyFinish,
		String lateStart, String slack, String lateFinish, boolean critical) {
	super();
	this.key = key;
	this.text = text;
	this.earlyStart = earlyStart;
	this.length = length;
	this.earlyFinish = earlyFinish;
	this.lateStart = lateStart;
	this.slack = slack;
	this.lateFinish = lateFinish;
	this.critical = critical;
}

public Integer getKey() {
	return key;
}
public void setKey(Integer key) {
	this.key = key;
}
public String getText() {
	return text;
}
public void setText(String text) {
	this.text = text;
}
public String getEarlyStart() {
	return earlyStart;
}
public void setEarlyStart(String earlyStart) {
	this.earlyStart = earlyStart;
}
public String getLength() {
	return length;
}
public void setLength(String length) {
	this.length = length;
}
public String getEarlyFinish() {
	return earlyFinish;
}
public void setEarlyFinish(String earlyFinish) {
	this.earlyFinish = earlyFinish;
}
public String getLateStart() {
	return lateStart;
}
public void setLateStart(String lateStart) {
	this.lateStart = lateStart;
}
public String getSlack() {
	return slack;
}
public void setSlack(String slack) {
	this.slack = slack;
}
public String getLateFinish() {
	return lateFinish;
}
public void setLateFinish(String lateFinish) {
	this.lateFinish = lateFinish;
}
public boolean isCritical() {
	return critical;
}
public void setCritical(boolean critical) {
	this.critical = critical;
}

}
