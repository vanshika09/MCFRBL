package struts.action.master;

import java.util.ArrayList;

import java.util.List;


import org.hibernate.Session;


import com.google.gson.Gson;
import beans.RollingStockCertificate;
import beans.TrialGenerationInRsc;
import beans.FurnishingTransaction;
import common.DateUtil;
import dao.DaoRSC;
import hibernateConnect.HibernateConfig;

public class SaveRollingStockCertificate {
	private String furnishingAssetId;
	private String rscDocNo;
	private String rscRevNo;
	private String docDate;
	private String orderNo;
	private String rscNo;
	private String rscModification;
    private String rscDeviation;
    private String primaryKeys;
    private String itemParticulars;
    private String frequency;
    private String fromDate;
    private String toDate;
    private String trial;
    private String coachDispatchDate;
    private String dispatchRly;
	private String dispatchDiv;
	private String docNoRSC;
	private String revNoRSC;
	
    public String saveData()
    {
    	Gson gson=new Gson();
    	Integer[] primaryKeyArr=gson.fromJson(primaryKeys, Integer[].class);
		String[] itemParticularsArr=gson.fromJson(itemParticulars, String[].class);
		String[] frequencyArr=gson.fromJson(frequency, String[].class);
		String[] fromDateArr=gson.fromJson(fromDate, String[].class);
		String[] toDateArr=gson.fromJson(toDate, String[].class);
		Session session=null;
		session=HibernateConfig.getSession();
		Integer furnishingAssetIdAsInt=Integer.parseInt(furnishingAssetId);
		
		FurnishingTransaction furnishingTransaction= (FurnishingTransaction) session.get(FurnishingTransaction.class, furnishingAssetIdAsInt);
		if(!"".equals(coachDispatchDate))
		{
			furnishingTransaction.setCoachDispatchDate(DateUtil.convertToDate(coachDispatchDate));
			System.out.println(coachDispatchDate);
		}
		
		furnishingTransaction.setDispatchRly(dispatchRly);
		furnishingTransaction.setDispatchDiv(dispatchDiv);
		furnishingTransaction.setRscFlag(1);
		
		RollingStockCertificate rollingStockCertificate=new RollingStockCertificate();
		rollingStockCertificate.setFurnishingAssetId(furnishingAssetIdAsInt);
		if(!"".equals(docDate))
		{
			rollingStockCertificate.setDocDate(DateUtil.convertToDate(docDate));
			System.out.println("Doc No: "+docDate);
		}
		
		rollingStockCertificate.setRscDocNo(docNoRSC);
		rollingStockCertificate.setRscRevNo(revNoRSC);
		rollingStockCertificate.setOrderNo(orderNo);
		rollingStockCertificate.setRscNo(rscNo);
		rollingStockCertificate.setRscModification(rscModification);
		rollingStockCertificate.setRscDeviation(rscDeviation);
		
		List<TrialGenerationInRsc> trialGenerationInRscListAdd= new ArrayList<TrialGenerationInRsc>();
		List<TrialGenerationInRsc> trialGenerationInRscListUpdate= new ArrayList<TrialGenerationInRsc>();
		System.out.println("trial : "+trial);
		if(trial.equals("Yes"))
		{
		for(int i=0; i<itemParticularsArr.length;i++)
			{
			if(primaryKeyArr[i]==0)
			{
			TrialGenerationInRsc spareAdd= new TrialGenerationInRsc();
			spareAdd.setFurnishingAssetId(furnishingAssetIdAsInt);
			spareAdd.setItemParticulars(itemParticularsArr[i]);
			spareAdd.setFrequency(frequencyArr[i]);
			System.out.println("From Date1: "+fromDateArr[i]);
			if(!"".equals(fromDateArr[i]))
			{
				spareAdd.setFromDate(DateUtil.convertToDate(fromDateArr[i]));
				System.out.println("From Date: "+fromDateArr[i]);
			}
			if(!"".equals(toDateArr[i]))
			{
				spareAdd.setToDate(DateUtil.convertToDate(toDateArr[i]));
				System.out.println(toDateArr[i]);
			}
			trialGenerationInRscListAdd.add(spareAdd);
			}
			else
			{
				TrialGenerationInRsc spareUpdate= (TrialGenerationInRsc) session.get(TrialGenerationInRsc.class, primaryKeyArr[i])	;
				//spareUpdate.setFurnishingAssetId(furnishingAssetIdAsInt);
				spareUpdate.setItemParticulars(itemParticularsArr[i]);
				spareUpdate.setFrequency(frequencyArr[i]);
				if(!"".equals(fromDateArr[i]))
				{
					spareUpdate.setFromDate(DateUtil.convertToDate(fromDateArr[i]));
					System.out.println(fromDateArr[i]);
				}
				if(!"".equals(toDateArr[i]))
				{
					spareUpdate.setToDate(DateUtil.convertToDate(toDateArr[i]));
					System.out.println(toDateArr[i]);
				}
				trialGenerationInRscListUpdate.add(spareUpdate);
			}
			}
		}
		try
		{
			DaoRSC dao=new DaoRSC();
			dao.saveData(furnishingTransaction, rollingStockCertificate, trialGenerationInRscListAdd, trialGenerationInRscListUpdate);
			return "success";
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return "error";
		}
    }

	public String getFurnishingAssetId() {
		return furnishingAssetId;
	}

	public void setFurnishingAssetId(String furnishingAssetId) {
		this.furnishingAssetId = furnishingAssetId;
	}

	public String getRscDocNo() {
		return rscDocNo;
	}

	public void setRscDocNo(String rscDocNo) {
		this.rscDocNo = rscDocNo;
	}

	public String getRscRevNo() {
		return rscRevNo;
	}

	public void setRscRevNo(String rscRevNo) {
		this.rscRevNo = rscRevNo;
	}

	public String getDocDate() {
		return docDate;
	}

	public void setDocDate(String docDate) {
		this.docDate = docDate;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getRscNo() {
		return rscNo;
	}

	public void setRscNo(String rscNo) {
		this.rscNo = rscNo;
	}

	public String getRscModification() {
		return rscModification;
	}

	public void setRscModification(String rscModification) {
		this.rscModification = rscModification;
	}

	public String getRscDeviation() {
		return rscDeviation;
	}

	public void setRscDeviation(String rscDeviation) {
		this.rscDeviation = rscDeviation;
	}

	public String getItemParticulars() {
		return itemParticulars;
	}

	public void setItemParticulars(String itemParticulars) {
		this.itemParticulars = itemParticulars;
	}

	public String getFrequency() {
		return frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getTrial() {
		return trial;
	}

	public void setTrial(String trial) {
		this.trial = trial;
	}

	public String getCoachDispatchDate() {
		return coachDispatchDate;
	}

	public void setCoachDispatchDate(String coachDispatchDate) {
		this.coachDispatchDate = coachDispatchDate;
	}

	public String getDispatchRly() {
		return dispatchRly;
	}

	public void setDispatchRly(String dispatchRly) {
		this.dispatchRly = dispatchRly;
	}

	public String getDispatchDiv() {
		return dispatchDiv;
	}

	public void setDispatchDiv(String dispatchDiv) {
		this.dispatchDiv = dispatchDiv;
	}

	public String getPrimaryKeys() {
		return primaryKeys;
	}

	public void setPrimaryKeys(String primaryKeys) {
		this.primaryKeys = primaryKeys;
	}

	public String getDocNoRSC() {
		return docNoRSC;
	}

	public void setDocNoRSC(String docNoRSC) {
		this.docNoRSC = docNoRSC;
	}

	public String getRevNoRSC() {
		return revNoRSC;
	}

	public void setRevNoRSC(String revNoRSC) {
		this.revNoRSC = revNoRSC;
	}
   
}
