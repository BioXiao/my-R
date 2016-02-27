suppressMessages(library(org.Hs.eg.db))
suppressMessages(library(reshape2))
suppressMessages(library(annotate))

gpl_info=read.csv("GPL_info.csv",stringsAsFactors = F)
gpl_info=gpl_info[grepl("Mus|Rattus|Homo",gpl_info[,3]),]

### first download all of the annotation packages from bioconductor
for (i in 1:nrow(gpl_info)){
  print(i)
  platform=gpl_info[i,4]
  platform=gsub('^ ',"",platform) ##��Ҫ����Ϊ�Ҵ��������ַ���ǰ���пո�
  #platformDB='hgu95av2.db'
  platformDB=paste(platform,".db",sep="")
  if( platformDB  %in% rownames(installed.packages()) == FALSE) {
    BiocInstaller::biocLite(platformDB)
    #source("http://bioconductor.org/biocLite.R");
    #biocLite(platformDB )
  } 
}
�����������еİ��� �Ϳ��Խ�����������оƬ̽����gene�Ķ�Ӧ��ϵ��
for (i in 1:nrow(gpl_info)){
  print(i)
  platform=gpl_info[i,4]
  platform=gsub('^ ',"",platform)
  #platformDB='hgu95av2.db'
  platformDB=paste(platform,".db",sep="")

  if( platformDB  %in% rownames(installed.packages()) != FALSE) {
    library(platformDB,character.only = T)
    #tmp=paste('head(mappedkeys(',platform,'ENTREZID))',sep='')
    #eval(parse(text = tmp))
###�ص���������ַ���������������
    all_probe=eval(parse(text = paste('mappedkeys(',platform,'ENTREZID)',sep='')))
    EGID <- as.numeric(lookUp(all_probe, platformDB, "ENTREZID"))
##�Լ�������д��������
  } 
}