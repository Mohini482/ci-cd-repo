public with sharing class Task1 {
    public Task1()
    {
       
    }
    public void task1Method()
    {
       
       String s= 'Apex SOQL SOSL Apex SOSL Program';
       Map<String, Integer> wordCounts = new Map<String, Integer>();
       string[] words = s.split(' ');
       for(String word: words) {
      Integer wordCount = wordCounts.get(word);
      if(wordCount == null)
       {
         wordCounts.put(word,1);
      }
      else 
      {
          wordcounts.put(word, wordCount+1);
      }
}
    system.debug(wordcounts);  
}
}