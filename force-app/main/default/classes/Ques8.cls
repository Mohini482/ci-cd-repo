public class Ques8 {

public void ques8Method()
{
List<Opportunity> lsopp = [Select amount from Opportunity Order By amount desc nulls last];   

Set<Decimal> setAmounts = new Set<Decimal>();
List<Decimal> lstAmounts = new List<Decimal>();

// Added values in set to avoid duplicate values
for(Opportunity objOpportunity : lsopp)
{
      setAmounts.add(objOpportunity.amount);
}

lstAmounts.addAll(setAmounts);

System.debug('Highest Amount: '+lstAmounts[0] );

System.debug('2nd Highest Amount: '+lstAmounts[1] );
}
}