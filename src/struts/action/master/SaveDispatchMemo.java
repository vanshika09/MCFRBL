package struts.action.master;


import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import beans.DispatchMemoPrimaryData;
import com.google.gson.Gson;
import dao.DaoSaveDispatchMemo;
import beans.FurnishingTransaction;
import common.DateUtil;
import hibernateConnect.HibernateConfig;

public class SaveDispatchMemo {
	private String furnishingAssetIdJson;
	private String coachNumberJson;
	private String docNo;
	private String revNo;
	private String docDate;
	private String fileNo;
	private String dateOfDispatchMemo;
	private String dispatchMemoNo;
	
	
	public String saveData()
	{
		Session session=null;
		session=HibernateConfig.getSession();
		Gson gson = new Gson();
		String [] coachNumberArr = gson.fromJson(coachNumberJson, String[].class);
		Integer [] furnishingAssetIdArr=gson.fromJson(furnishingAssetIdJson, Integer[].class);
		List<FurnishingTransaction> ftList= new ArrayList<FurnishingTransaction>();
		for(Integer f: furnishingAssetIdArr)
		{
			FurnishingTransaction ft=(FurnishingTransaction) session.get(FurnishingTransaction.class, f);
			ft.setDispatchMemoDate(DateUtil.convertToDate(dateOfDispatchMemo));
			ftList.add(ft);
		}
		DispatchMemoPrimaryData dispatchMemoPrimaryData=new DispatchMemoPrimaryData();
		System.out.println("Doc No: "+docNo+ "Rev No: "+revNo+ "fileNo: "+fileNo);
		dispatchMemoPrimaryData.setDispatchMemoDocNo(docNo);
		dispatchMemoPrimaryData.setDispatchMemoRevNo(revNo);
		dispatchMemoPrimaryData.setDispatchMemoDocDate(DateUtil.convertToDate(docDate));
		dispatchMemoPrimaryData.setDispatchMemoFileNo(fileNo);
		dispatchMemoPrimaryData.setDispatchMemoNo(dispatchMemoNo);
		dispatchMemoPrimaryData.setDispatchMemoDate(DateUtil.convertToDate(dateOfDispatchMemo));
		Timestamp timestamp= new Timestamp(System.currentTimeMillis());
		dispatchMemoPrimaryData.setEntryDate(timestamp);
		HttpSession session_http = ServletActionContext.getRequest().getSession(true);
		String userID = (String) session_http.getAttribute("userid");
		System.out.println("Entry by :"+userID);
		dispatchMemoPrimaryData.setEntryBy(userID);
		try {
			DaoSaveDispatchMemo dao=new DaoSaveDispatchMemo();
			dao.saveData(ftList,dispatchMemoPrimaryData,furnishingAssetIdArr, coachNumberArr);
			return "success";
		} 
		catch (Exception e) {
			e.printStackTrace();
			return "null";
		}
		finally
		{
			if(session!=null)
			{
				session.close();
			}
		}
		
	}


	public String getFurnishingAssetIdJson() {
		return furnishingAssetIdJson;
	}


	public void setFurnishingAssetIdJson(String furnishingAssetIdJson) {
		this.furnishingAssetIdJson = furnishingAssetIdJson;
	}


	public String getCoachNumberJson() {
		return coachNumberJson;
	}


	public void setCoachNumberJson(String coachNumberJson) {
		this.coachNumberJson = coachNumberJson;
	}


	public String getDocNo() {
		return docNo;
	}


	public void setDocNo(String docNo) {
		this.docNo = docNo;
	}


	public String getRevNo() {
		return revNo;
	}


	public void setRevNo(String revNo) {
		this.revNo = revNo;
	}


	public String getDocDate() {
		return docDate;
	}


	public void setDocDate(String docDate) {
		this.docDate = docDate;
	}


	public String getFileNo() {
		return fileNo;
	}


	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}


	public String getDateOfDispatchMemo() {
		return dateOfDispatchMemo;
	}


	public void setDateOfDispatchMemo(String dateOfDispatchMemo) {
		this.dateOfDispatchMemo = dateOfDispatchMemo;
	}


	public String getDispatchMemoNo() {
		return dispatchMemoNo;
	}


	public void setDispatchMemoNo(String dispatchMemoNo) {
		this.dispatchMemoNo = dispatchMemoNo;
	}
	
}
