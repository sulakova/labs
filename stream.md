**Stream analytics demo:**
```#SQL
WITH subquery AS (  
        SELECT message, sentiment(message) as result from tweetsin  
    )
   
    select System.TimeStamp AS Time, avg(result.[Score]), count (1)
    into tweetsbi2
    from subquery
    GROUP BY  SlidingWindow(second, 5)
```

sentiment() is a function wrapping Machine Learning Twitter sentiment analysys
