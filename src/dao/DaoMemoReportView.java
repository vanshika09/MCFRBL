package dao;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import beans.CoachMemoDispatchView;
import common.DateUtil;
import hibernateConnect.HibernateConfig;

public class DaoMemoReportView {

	public List<CoachMemoDispatchView> getAllMemo(String datefrom, String dateto, String jtSorting) {
		Session session=null;
		session=HibernateConfig.getSession();
		List<CoachMemoDispatchView> list = null; 
		try{
		Criteria cr=session.createCriteria(CoachMemoDispatchView.class);
		if(datefrom!=null)
		{
			if(!"".equals(datefrom))
			{
				Date	from=DateUtil.convertToDate(datefrom);
				cr.add(Restrictions.ge("dispatchMemoDate", from));
			}
		}
		if(dateto!=null)
		{
			if(!"".equals(dateto))
			{
				Date	to=DateUtil.convertToDate(dateto);
				cr.add(Restrictions.le("dispatchMemoDate", to));
			}
		}
		String[] temp;
        String delimiter = " ";
        /* given string will be split by the argument delimiter provided. */
        temp = jtSorting.split(delimiter);
         if(jtSorting.endsWith("ASC"))
	         {
	        	 cr.addOrder(Order.asc(temp[0]));
	         }
	         else if(jtSorting.endsWith("DESC"))
	         {
	        	 cr.addOrder(Order.desc(temp[0]));	 
	         }
	list=cr.list();
	}
catch(Exception e)
		{
	System.out.println("--- Error Inside dao.DaoMemoReportView getAllMemo() methods catch block---");
	e.printStackTrace();
		}
		finally
		{
			if(session!=null)
			{
				session.close();
			}
		}
		return list;
	}
}
