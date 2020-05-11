package beans;

import java.util.Date;

public class DispatchMemoPrimaryData implements java.io.Serializable {

private static final long serialVersionUID = 1L; 

private Integer dispatchMemoId;
private String dispatchMemoDocNo;
private String dispatchMemoRevNo;
private Date dispatchMemoDocDate;
private Date dispatchMemoDate;
private String dispatchMemoFileNo;
private String dispatchMemoNo;
private Date entryDate;
private String entryBy;

public DispatchMemoPrimaryData()
{
	
}

public DispatchMemoPrimaryData(Integer dispatchMemoId, String dispatchMemoDocNo, String dispatchMemoRevNo,
		Date dispatchMemoDocDate, Date dispatchMemoDate, String dispatchMemoFileNo, String dispatchMemoNo,Date entryDate, String entryBy) {
	super();
	this.dispatchMemoId = dispatchMemoId;
	this.dispatchMemoDocNo = dispatchMemoDocNo;
	this.dispatchMemoRevNo = dispatchMemoRevNo;
	this.dispatchMemoDocDate = dispatchMemoDocDate;
	this.dispatchMemoDate = dispatchMemoDate;
	this.dispatchMemoFileNo = dispatchMemoFileNo;
	this.dispatchMemoNo=dispatchMemoNo;
	this.entryDate = entryDate;
	this.entryBy = entryBy;
}

public Integer getDispatchMemoId() {
	return dispatchMemoId;
}

public void setDispatchMemoId(Integer dispatchMemoId) {
	this.dispatchMemoId = dispatchMemoId;
}

public String getDispatchMemoDocNo() {
	return dispatchMemoDocNo;
}

public void setDispatchMemoDocNo(String dispatchMemoDocNo) {
	this.dispatchMemoDocNo = dispatchMemoDocNo;
}

public String getDispatchMemoRevNo() {
	return dispatchMemoRevNo;
}

public void setDispatchMemoRevNo(String dispatchMemoRevNo) {
	this.dispatchMemoRevNo = dispatchMemoRevNo;
}

public Date getDispatchMemoDocDate() {
	return dispatchMemoDocDate;
}

public void setDispatchMemoDocDate(Date dispatchMemoDocDate) {
	this.dispatchMemoDocDate = dispatchMemoDocDate;
}

public Date getDispatchMemoDate() {
	return dispatchMemoDate;
}

public void setDispatchMemoDate(Date dispatchMemoDate) {
	this.dispatchMemoDate = dispatchMemoDate;
}

public String getDispatchMemoFileNo() {
	return dispatchMemoFileNo;
}

public void setDispatchMemoFileNo(String dispatchMemoFileNo) {
	this.dispatchMemoFileNo = dispatchMemoFileNo;
}

public String getDispatchMemoNo() {
	return dispatchMemoNo;
}

public void setDispatchMemoNo(String dispatchMemoNo) {
	this.dispatchMemoNo = dispatchMemoNo;
}

public Date getEntryDate() {
	return entryDate;
}

public void setEntryDate(Date entryDate) {
	this.entryDate = entryDate;
}

public String getEntryBy() {
	return entryBy;
}

public void setEntryBy(String entryBy) {
	this.entryBy = entryBy;
}

}
