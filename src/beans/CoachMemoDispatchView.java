package beans;

import java.util.Date;

public class CoachMemoDispatchView implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private Integer dispatchMemoId;
	private String docno;
	private Date dispatchMemoDate;
	private String dispatchMemoFileNo;
	private String dispatchMemoNo;
	private String coachno;
	private String coachtype;
	private String shellno;
	private String furno;
public CoachMemoDispatchView()
{
	
}
public CoachMemoDispatchView(Integer dispatchMemoId, String docno, Date dispatchMemoDate, String dispatchMemoFileNo,
		String dispatchMemoNo, String coachno, String coachtype, String shellno, String furno) {
	super();
	this.dispatchMemoId = dispatchMemoId;
	this.docno = docno;
	this.dispatchMemoDate = dispatchMemoDate;
	this.dispatchMemoFileNo = dispatchMemoFileNo;
	this.dispatchMemoNo = dispatchMemoNo;
	this.coachno = coachno;
	this.coachtype = coachtype;
	this.shellno = shellno;
	this.furno = furno;
}
public Integer getDispatchMemoId() {
	return dispatchMemoId;
}
public void setDispatchMemoId(Integer dispatchMemoId) {
	this.dispatchMemoId = dispatchMemoId;
}
public String getDocno() {
	return docno;
}
public void setDocno(String docno) {
	this.docno = docno;
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
public String getCoachno() {
	return coachno;
}
public void setCoachno(String coachno) {
	this.coachno = coachno;
}
public String getCoachtype() {
	return coachtype;
}
public void setCoachtype(String coachtype) {
	this.coachtype = coachtype;
}
public String getShellno() {
	return shellno;
}
public void setShellno(String shellno) {
	this.shellno = shellno;
}
public String getFurno() {
	return furno;
}
public void setFurno(String furno) {
	this.furno = furno;
}


}
