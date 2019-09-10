instr <- function(str1,str2,startpos=1,n=1){
  aa=unlist(strsplit(substring(str1,startpos),str2))
  if(length(aa) < n+1 ) return(0);
  return(sum(nchar(aa[1:n])) + startpos+(n-1)*nchar(str2) )
}

numextract <- function(string){ 
  str_extract(string, "\\-*\\d+\\.*\\d*")
} 

trim <- function (x) gsub("^\\s+|\\s+$", "", x)
