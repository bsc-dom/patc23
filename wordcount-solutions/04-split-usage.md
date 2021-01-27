# Using the `split` method

As explained before, `StorageCollection` subtypes have a `split` method that can be used.

It is specially useful for distributed storage and parallel computation (you will see during this afternoon!) but we will start to showcase it through a simple sequential exercise with the WordCount application.


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


## Prepare the helper functions

Prepare the following functions. You may --you are encouraged to-- reuse existing code from previous exercises:


```python
def wordcount(block):
    """Count the occurrences of unique words.
    
    :param block: A StorageDict block, coming from a text.
    :return: A dictionary of <word, occurrences>.
    """
    ...
    
    # ****************************
    # Solution
    # ****************************
    partial_result = dict()
    for word in block.values():
        if word in partial_result:
            partial_result[word] += 1
        else:
            partial_result[word] = 1
    return partial_result
    # ****************************


def merge_results(partial, result):
    """Given a partial dictionary of results, merge it into the final result.
    
    :param partial: A partial wordcount.
    :param result: The final Result instance (modified in-place).
    """
    ...
    
    # ****************************
    # Solution
    # ****************************
    for word, instances in partial.items():
        if word in result:
            result[word] += instances
        else:
            result[word] = instances
    # ****************************

```

## Prepare the main

You will need to use the `split` method and also use the previous two functions that you have prepared in the previous cell.



```python
# Retrieve the persistent Words object
words = ...
# Prepare the output
result = ...

for block in words.split():
    ...
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    <ipython-input-3-1e47bc51ba64> in <module>()
          4 result = ...
          5 
    ----> 6 for block in words.split():
          7     ...


    AttributeError: 'ellipsis' object has no attribute 'split'



```python

# ****************************
# Solution
# ****************************

words = Words.get_by_alias("WordCountWords")
result = Result()

for block in words.split():
    partial = wordcount(block)
    merge_results(partial, result)
    
print("Number of unique words:", len(result))

# ****************************

```

    Number of unique words: 186



```python

```
