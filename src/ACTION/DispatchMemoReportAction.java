package ACTION;


import java.util.List;

import com.opensymphony.xwork2.ActionSupport;

import beans.CoachMemoDispatchView;

import dao.DaoMemoReportView;
public class DispatchMemoReportAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private List<CoachMemoDispatchView> records;
	private String result;
	private String message;
	private CoachMemoDispatchView record;
	private Integer dispatchMemoId;
	private String docno;
	private String dispatchMemoDate;
	private String dispatchMemoFileNo;
	private String dispatchMemoNo;
	private String coachno;
	private String coachtype;
	private String shellno;
	private String furno;
	private String datefrom;
	private String dateto;
	private String jtSorting;
	
	public String available()
	{
		try
		{
			DaoMemoReportView dao=new DaoMemoReportView();
			setRecords(dao.getAllMemo(datefrom, dateto, jtSorting));
			setResult("OK");
		}
		catch(Exception e)
		{
			setResult("ERROR");
			setMessage(e.getMessage());
			System.err.println(e.getMessage());
		}
				return ActionSupport.SUCCESS;
	}

	public List<CoachMemoDispatchView> getRecords() {
		return records;
	}

	public void setRecords(List<CoachMemoDispatchView> records) {
		this.records = records;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public CoachMemoDispatchView getRecord() {
		return record;
	}

	public void setRecord(CoachMemoDispatchView record) {
		this.record = record;
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

	public String getDispatchMemoDate() {
		return dispatchMemoDate;
	}

	public void setDispatchMemoDate(String dispatchMemoDate) {
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

	public String getDatefrom() {
		return datefrom;
	}

	public void setDatefrom(String datefrom) {
		this.datefrom = datefrom;
	}

	public String getDateto() {
		return dateto;
	}

	public void setDateto(String dateto) {
		this.dateto = dateto;
	}

	public String getJtSorting() {
		return jtSorting;
	}

	public void setJtSorting(String jtSorting) {
		this.jtSorting = jtSorting;
	}
	
}
