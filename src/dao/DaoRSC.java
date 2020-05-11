package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import beans.FurnishingTransaction;
import beans.RollingStockCertificate;
import beans.TrialGenerationInRsc;
import hibernateConnect.HibernateConfig;

public class DaoRSC {

	public void saveData(FurnishingTransaction furnishingTransaction, RollingStockCertificate rollingStockCertificate,
			List<TrialGenerationInRsc> trialGenerationInRscListAdd,List<TrialGenerationInRsc> trialGenerationInRscListUpdate) {
		Session session=null;
		session=HibernateConfig.getSession();
		Transaction tx=null;
		
		try
		
		{
			tx=session.beginTransaction();
			session.update(furnishingTransaction);
			session.saveOrUpdate(rollingStockCertificate);
			for(TrialGenerationInRsc t:trialGenerationInRscListAdd)
			{
			session.save(t);
			}
			for(TrialGenerationInRsc tg:trialGenerationInRscListUpdate)
			{
			session.update(tg);
			}
			tx.commit();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			tx.rollback();
		}
		finally
		{
			if(session!=null)
			{
				session.close();
			}
		}
	}

}
