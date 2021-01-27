# WordCount

## Check the data model (classes)

You can check the classes definitions by going into the [model](model/) folder.

You will find two different files:

 - `words.py` which contains the `Words` class, intended to store the collection of words.
 - `result.py` which contains the `Result` class, intended to store the result of the Word Count.

## Text Generation

Initialize the Storage Library, and read some Lorem Ipsum text from a file.


```python
import storage.api

storage.api.init()
```

    --- Using global.properties at /gpfs/home/nct00/nct00004/dataclay-patc21/wordcount/cfgfiles/global.properties
    No global.properties file found. Using default values
    --- Using global.properties at /gpfs/home/nct00/nct00004/.dataClay/13911894/client/cfgfiles/global.properties
    Found global.properties variable EE_PERSISTENT_INFO_PATH=/home/nct00/nct00004/.dataClay/13911894/client/storage/ and type <class 'str'>
    Found global.properties variable STATE_FILE_PATH=/home/nct00/nct00004/.dataClay/13911894/client/storage/state.txt and type <class 'str'>



```python
# Read the data from the loremipsum.txt
with open("loremipsum.txt") as f:
    lipsum_text = f.read()
    lipsum_text

print ("Size of the \"Lorem Ipsum\" text: %d characters" % len(lipsum_text))
```

    Size of the "Lorem Ipsum" text: 56086 characters



```python
# Split the data into words and store it in the data structure:
from model.words import Words

w = Words()

# Make the data structure persistent (with the alias "WordCountWords")
w.make_persistent("WordCountWords")

print("Words is persistent and is empty (#%d elements)" % len(w))

for i, item in enumerate(lipsum_text.split()):
    # Remove punctuation signs and make the word lowercase
    sanitized = item.strip('.,').lower()
    w[i] = sanitized

print("Number of iterations done: %d" % (i + 1))
print("`Words`' objects has been populated, number of elements: %d" % len(w))
```

    Words is persistent and is empty (#0 elements)
    Number of iterations done: 8297
    `Words`' objects has been populated, number of elements: 8297


Check that the object has been persisted and the number of words is the expected one:


```python
w_bis = Words.get_by_alias("WordCountWords")
print("Number of words persisted:", len(w_bis))
```

    Number of words persisted: 8297



```python

```
