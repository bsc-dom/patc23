# WordCount application

Let's do a WordCount!

First of all, let's initialize the Storage Library and import the models:


```python
import storage.api
storage.api.init()

from model.words import Words
from model.result import Result
```

    --- Using global.properties at /gpfs/home/nct00/nct00004/dataclay-patc21/wordcount/cfgfiles/global.properties
    No global.properties file found. Using default values
    --- Using global.properties at /gpfs/home/nct00/nct00004/.dataClay/13911894/client/cfgfiles/global.properties
    Found global.properties variable EE_PERSISTENT_INFO_PATH=/home/nct00/nct00004/.dataClay/13911894/client/storage/ and type <class 'str'>
    Found global.properties variable STATE_FILE_PATH=/home/nct00/nct00004/.dataClay/13911894/client/storage/state.txt and type <class 'str'>


## Getting the word collection from persistence

We can retrieve the persistent collection library with the classmethod `get_by_alias`.

You must use the same alias used when doing the `make_persistent` call.


```python
words = ...

# ****************************
# Solution
# ****************************
words = Words.get_by_alias("WordCountWords")
# ****************************

print("Ready to count words on the text. Number of words: #%d" % len(words))
```

    Ready to count words on the text. Number of words: #8297


## Preparing the Result structure

We will be using the `Result` data structure, which will contain the number of occurrences (value) for each word (key) in the text.


```python
result = ...

# ****************************
# Solution
# ****************************
result = Result()
result.make_persistent("wc_results")
# ****************************


print("Empty dictionary ready: %s (#%d elements)" % (result, len(result)))
```

    Empty dictionary ready: StorageDict({}) (#0 elements)


## Performing the Word Count

**Exercise:** Count occurrences of unique words in the collection `Words`.

*Hint:* Words is a Mapping-like data structure; as such, it is iterable in various forms. Remember that you want to iterate the `values` of that dictionary!

*Hint:* Result starts empty, you will be populating it as you go.


```python
...

# ****************************
# Solution
# ****************************
for word in words.values():
    if word in result:
        result[word] += 1
    else:
        result[word] = 1
# ****************************


print("Number of unique words:", len(result))
```

    Number of unique words: 186


If you haven't made `result` persistent, now it's the time to do it.

Remember to give it a memorable alias!


```python
...

# ****************************
# Solution
# ****************************
# Already made persistent in the 3rd box
# Alias used: "wc_results"
# ****************************
```




    Ellipsis




```python

```
