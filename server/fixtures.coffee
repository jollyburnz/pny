if Emails.find().count() is 0
  Emails.insert
    email: 'jollyburnz@gmail.com'
    
  Emails.insert
    email: 'philzelonky@gmail.com'

if Photo1.find().count() is 0
  Photo1.insert
    filename: 'insta-home_test.jpg'
    url: 'https://www.filepicker.io/api/file/jEXMwNNMSImfr2nJfeit'
    date: new Date()

if Photo2.find().count() is 0
  Photo2.insert
    filename: 'skyline.jpg'
    url: 'https://www.filepicker.io/api/file/Yd08tBh8Q7mLfJ9KK6MS'
    date: new Date()

if Photo3.find().count() is 0
  Photo3.insert
    filename: 'bridge.jpg'
    url: 'https://www.filepicker.io/api/file/zenJv4RxQL6HWKCOEDjg'
    date: new Date()

if Title2.find().count() is 0
  Title2.insert
    title: 'Friday, February 14'
    date: new Date()

if Title3.find().count() is 0
  Title3.insert
    title: 'News'
    date: new Date()