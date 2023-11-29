public class Ques5 {
    public void ques5Method()
    {
        // List<Quote> quotes = [select id,name , opportunityid,(select quoteid from quotelineitems) from quote];
        // System.debug(quotes);
        /*map<string,list<quotelineitem>> map1=new map<string,list<quotelineitem>>();
        list<quote> quote1=[select id,opportunity.name,(select QuoteId from QuoteLineItems) from quote];
        for(quote quote2:quote1)
        {
            map1.put(quote2.opportunity.name,quote2.QuoteLineItems);
        }
       system.debug(map1);
        */   
        map<string,list<quotelineitem>> samplemap = new map<string,list<quotelineitem>>();
        list<quote> qlst = [select opportunity.name,name,(select quoteid from quotelineitems) from quote];
        for(quote qt: qlst)
        {
            samplemap.put(qt.opportunity.name,qt.quotelineitems);
        }
        system.debug(samplemap);
    }
}