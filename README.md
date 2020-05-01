# Workflowy to VimWiki Converter

Simple application to help people migrate from [Workflowy](https://workflowy.com/) into [VimWiki](https://github.com/vimwiki/vimwiki). 

###Instructions: 

* Ensure you have Ruby installed (`sudo apt install ruby`). 
* Log into Workflowy and under settings choose "Export All". 
* Ensure you have selected "OPML" and copy-paste all the data into a file on your system. 
* Run the app, point it to the file with the OPML data and then point it to the folder you would like to contain the VimWiki. 

###Note:
Because Workflowy is uses a [tree data structure](https://en.wikipedia.org/wiki/Tree_(data_structure)), where VimWiki uses a [graph data structure](https://en.wikipedia.org/wiki/Graph_(abstract_data_type)), there are some fundamental incompatibilities between the systems. 

If you have any trees in Workflowy with the same title, VimWiki would treat these as the same entry, and include all the data into the one file. 

To overcome this, if the app ever comes across any entries that have the same title, it simply prepends the title with ">", to make it unique. It is not so pretty, but it is effective. 
