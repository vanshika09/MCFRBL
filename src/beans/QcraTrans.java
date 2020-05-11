package beans;
// Generated 20 Mar, 2020 5:30:42 PM by Hibernate Tools 4.0.1.Final

import java.util.Date;

/**
 * QcraTrans generated by hbm2java
 */
public class QcraTrans implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private QcraTransId id;
	private String docNoQcra;
	private String revNoQcra;
	private Date dateOfDocQcra;
	private Date dateOfTesting;
	private String shifOfTesting;
	
	private String natureOfQc;
	private String assemblyDetail;
	private String componentNoReference;
	private String rectification;
	private String defectReportNo;
	private Date defectReportDate;
	private String pointNoRectified;
	private String itemPointNo;
	private String pointNoNotRectified;
	private String observationRemark;
	private String entryBy;
	private Date entryTime;

	public QcraTrans() {
	}

	public QcraTrans(QcraTransId id) {
		this.id = id;
	}

	public QcraTrans(QcraTransId id, String docNoQcra, String revNoQcra, Date dateOfDocQcra, Date dateOfTesting,
			String shifOfTesting,  String natureOfQc,
			String assemblyDetail, String componentNoReference, String rectification, String defectReportNo,
			Date defectReportDate, String pointNoRectified, String itemPointNo, String pointNoNotRectified,
			String observationRemark, String entryBy, Date entryTime) {
		this.id = id;
		this.docNoQcra = docNoQcra;
		this.revNoQcra = revNoQcra;
		this.dateOfDocQcra = dateOfDocQcra;
		this.dateOfTesting = dateOfTesting;
		this.shifOfTesting = shifOfTesting;
		
		this.natureOfQc = natureOfQc;
		this.assemblyDetail = assemblyDetail;
		this.componentNoReference = componentNoReference;
		this.rectification = rectification;
		this.defectReportNo = defectReportNo;
		this.defectReportDate = defectReportDate;
		this.pointNoRectified = pointNoRectified;
		this.itemPointNo = itemPointNo;
		this.pointNoNotRectified = pointNoNotRectified;
		this.observationRemark = observationRemark;
		this.entryBy = entryBy;
		this.entryTime = entryTime;
	}

	public QcraTransId getId() {
		return this.id;
	}

	public void setId(QcraTransId id) {
		this.id = id;
	}

	public String getDocNoQcra() {
		return this.docNoQcra;
	}

	public void setDocNoQcra(String docNoQcra) {
		this.docNoQcra = docNoQcra;
	}

	public String getRevNoQcra() {
		return this.revNoQcra;
	}

	public void setRevNoQcra(String revNoQcra) {
		this.revNoQcra = revNoQcra;
	}

	public Date getDateOfDocQcra() {
		return this.dateOfDocQcra;
	}

	public void setDateOfDocQcra(Date dateOfDocQcra) {
		this.dateOfDocQcra = dateOfDocQcra;
	}

	public Date getDateOfTesting() {
		return this.dateOfTesting;
	}

	public void setDateOfTesting(Date dateOfTesting) {
		this.dateOfTesting = dateOfTesting;
	}

	public String getShifOfTesting() {
		return this.shifOfTesting;
	}

	public void setShifOfTesting(String shifOfTesting) {
		this.shifOfTesting = shifOfTesting;
	}

	
	public String getNatureOfQc() {
		return this.natureOfQc;
	}

	public void setNatureOfQc(String natureOfQc) {
		this.natureOfQc = natureOfQc;
	}

	public String getAssemblyDetail() {
		return this.assemblyDetail;
	}

	public void setAssemblyDetail(String assemblyDetail) {
		this.assemblyDetail = assemblyDetail;
	}

	public String getComponentNoReference() {
		return this.componentNoReference;
	}

	public void setComponentNoReference(String componentNoReference) {
		this.componentNoReference = componentNoReference;
	}

	public String getRectification() {
		return this.rectification;
	}

	public void setRectification(String rectification) {
		this.rectification = rectification;
	}

	public String getDefectReportNo() {
		return this.defectReportNo;
	}

	public void setDefectReportNo(String defectReportNo) {
		this.defectReportNo = defectReportNo;
	}

	public Date getDefectReportDate() {
		return this.defectReportDate;
	}

	public void setDefectReportDate(Date defectReportDate) {
		this.defectReportDate = defectReportDate;
	}

	public String getPointNoRectified() {
		return this.pointNoRectified;
	}

	public void setPointNoRectified(String pointNoRectified) {
		this.pointNoRectified = pointNoRectified;
	}

	public String getItemPointNo() {
		return this.itemPointNo;
	}

	public void setItemPointNo(String itemPointNo) {
		this.itemPointNo = itemPointNo;
	}

	public String getPointNoNotRectified() {
		return this.pointNoNotRectified;
	}

	public void setPointNoNotRectified(String pointNoNotRectified) {
		this.pointNoNotRectified = pointNoNotRectified;
	}

	public String getObservationRemark() {
		return this.observationRemark;
	}

	public void setObservationRemark(String observationRemark) {
		this.observationRemark = observationRemark;
	}

	public String getEntryBy() {
		return this.entryBy;
	}

	public void setEntryBy(String entryBy) {
		this.entryBy = entryBy;
	}

	public Date getEntryTime() {
		return this.entryTime;
	}

	public void setEntryTime(Date entryTime) {
		this.entryTime = entryTime;
	}

}