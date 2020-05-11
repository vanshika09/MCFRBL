package struts.action.master;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import beans.FurnishingTransaction;
import beans.RollingStockCertificate;
import beans.TrialGenerationInRsc;
import hibernateConnect.HibernateConfig;

public class ShowRSCData {
	private String furnishingAssetId;
	private String docNo;
	private String revNo;
	private RollingStockCertificate rollingStockCertificate;
	private List<TrialGenerationInRsc> trialGenerationInRsc;
	private FurnishingTransaction furnishingTransaction;
	String dispatchRly;
	String dispatchDiv;
	public String showData()
	{
		Integer furnishingAssetIdAsInt=Integer.parseInt(furnishingAssetId);
		Session session=null;
		session=HibernateConfig.getSession();
		docNo="MCF/RBL/QMF 8002";
		revNo="00";
		try
		{
			System.out.println("Rolling stock still undefined and furnising id :"+furnishingAssetIdAsInt);
			rollingStockCertificate=(RollingStockCertificate) session.get(RollingStockCertificate.class, furnishingAssetIdAsInt);
			if(rollingStockCertificate!=null)
			{
			   docNo=	rollingStockCertificate.getRscDocNo();
				revNo=rollingStockCertificate.getRscRevNo();
			}
			//System.out.println("Rolling stock1 :"+rollingStockCertificate.getRscNo());
			furnishingTransaction=(FurnishingTransaction) session.get(FurnishingTransaction.class, furnishingAssetIdAsInt);
			Criteria cr =session.createCriteria(TrialGenerationInRsc.class);

			cr.add(Restrictions.eq("furnishingAssetId", furnishingAssetIdAsInt));

			trialGenerationInRsc=  cr.list();

			return "success";
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return "error";
		}
		finally
		{
			if(session!=null)
			{
				session.close();
			}
		}
	}
	public String getFurnishingAssetId() {
		return furnishingAssetId;
	}
	public void setFurnishingAssetId(String furnishingAssetId) {
		this.furnishingAssetId = furnishingAssetId;
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
	public RollingStockCertificate getRollingStockCertificate() {
		return rollingStockCertificate;
	}
	public void setRollingStockCertificate(RollingStockCertificate rollingStockCertificate) {
		this.rollingStockCertificate = rollingStockCertificate;
	}
	
	public List<TrialGenerationInRsc> getTrialGenerationInRsc() {
		return trialGenerationInRsc;
	}
	public void setTrialGenerationInRsc(List<TrialGenerationInRsc> trialGenerationInRsc) {
		this.trialGenerationInRsc = trialGenerationInRsc;
	}
	public FurnishingTransaction getFurnishingTransaction() {
		return furnishingTransaction;
	}
	public void setFurnishingTransaction(FurnishingTransaction furnishingTransaction) {
		this.furnishingTransaction = furnishingTransaction;
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
	
}
