# Instrument Learn Easy
## Project background
Instrument Learn Easy (ILE) is an online platform that connects instrument learners with suitable teachers. When you embark on your journey to learn a new instrument, finding the right teacher can be a daunting task. With so many genres and styles of music, it is crucial to find a teacher who specializes in the type of music that interests you. Choosing the wrong teacher can lead to a loss of passion, wasted time, and money. Instrument Learn Easy helps you avoid these pitfalls by pairing you with a teacher who is a master in the genre that inspires you. Our platform is designed to make the search for the perfect teacher for your music journey easy and convenient.

## DB Structure

### Tables
|Table name|Description|
|----------|-----------|
|users|Everyone are users in ILE and having the basic attributes of a person.|
|instrument|Instrument indicates the name and type of an instrument.|
|learners|Users could be multiple instrument learners.|
|teachers|Users could be multiple instrument teacher and they could be learner and teacher at the same time.|
|teaching_price|Hourly rate of teaching.|
|genres|Genres of learner and teacher. Each role could have multiple interested genre.|
|learners_genres|junction table|
|teachers_genres|junction table|
|teacher_availabilities|Teacher could show their availability and allow learner to make a book request.|
|learner_booking|A booking request from learner, the booking time and duration could be different from availability.|

### Views
|View name|Description|
|----------|-----------|
|view_instrument_level_avg_price|show each instrument and their corresponding level with the average price|

### Queries
- Popularity of instrument for learner
- Popularity of genre for learner
- Popularity of teacher
- Popularity of teacher in a specific genre
- Popularity of teacher in a specific instrument
- Average price of teacher in a specific instrument
- Average price in specific genre

### ERD Diagram
![Image](/assets/erd.png)