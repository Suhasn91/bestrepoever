public with sharing class ChartController 
{
    public class Month 
    {
        public Integer count {get; set;}
        public Integer count1 {get; set;}
        public String yearMonth {get; set; }
        Month(Integer count, Integer count1, String yearMonth) 
        {
            this.count = count;
            this.count1 = count1;
            this.yearMonth = yearMonth;
        }
    }

    public Month[] getMonths() 
    {
        Month[] months = new Month[] {};
        months.add(new Month(10, 20, 'Jan-2018'));
        months.add(new Month(20, 20, 'Feb-2018'));
        months.add(new Month(30, 35, 'Mar-2018'));
        months.add(new Month(40, 20, 'Apr-2018'));
        return months;
    }
}