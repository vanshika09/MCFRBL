package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import beans.DispatchMemoTran;
import beans.DispatchMemoPrimaryData;
import beans.FurnishingTransaction;
import hibernateConnect.HibernateConfig;

public class DaoSaveDispatchMemo {

	public void saveData(List<FurnishingTransaction> ftList, DispatchMemoPrimaryData dispatchMemoPrimaryData,
			Integer[] furnishingAssetIdArr, String[] coachNumberArr) {
		Session session=null;
		session=HibernateConfig.getSession();
		Transaction tx=session.beginTransaction();
		try
		{
		for(FurnishingTransaction f:ftList)
		{
			session.update(f);
		}
		session.save(dispatchMemoPrimaryData);
		Integer dispatchMemoId=dispatchMemoPrimaryData.getDispatchMemoId();
		for(int i=0; i<furnishingAssetIdArr.length; i++)
		{
			DispatchMemoTran dt=new DispatchMemoTran();
			dt.setDispatchMemoId(dispatchMemoId);
			dt.setCoachNo(coachNumberArr[i]);
			dt.setFurnishingAssetId(furnishingAssetIdArr[i]);
			session.save(dt);
		}
		tx.commit();
		}
	
		catch(Exception e)
		{
			e.printStackTrace();
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


