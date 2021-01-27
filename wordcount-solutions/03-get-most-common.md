# Get the most common word

Now is your turn to do an application, with no _training wheels_.

The exercise is:

> Print the word with most occurrences, alongside its count.

You will, roughly, need to follow the following steps:

 - Initialize the `storage` library.
 - Retrieve the persistent `Result` instance.
 - Iterate all the results.
 - Check which word has most occurrences.
 - Print the overall most common word alongside its number of occurrences.


```python
# ****************************
# Solution
# ****************************
import storage.api
storage.api.init()

from model.result import Result

r = Result.get_by_alias("wc_results")

max_value = -1
max_word = None

for word, occ in r.items():
    if occ > max_value:
        max_value = occ
        max_word = word

print ("Word with most occurrences: `%s` (appearing %d times)" % (max_word, max_value))
# ****************************


```

    --- Using global.properties at /gpfs/home/nct00/nct00004/dataclay-patc21/wordcount/cfgfiles/global.properties
    No global.properties file found. Using default values
    --- Using global.properties at /gpfs/home/nct00/nct00004/.dataClay/13911894/client/cfgfiles/global.properties
    Found global.properties variable EE_PERSISTENT_INFO_PATH=/home/nct00/nct00004/.dataClay/13911894/client/storage/ and type <class 'str'>
    Found global.properties variable STATE_FILE_PATH=/home/nct00/nct00004/.dataClay/13911894/client/storage/state.txt and type <class 'str'>
    Word with most occurrences: `sed` (appearing 176 times)



```python

```
