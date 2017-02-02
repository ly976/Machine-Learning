function result = Pearson(x,y)

 covMatrix = cov(x,y);
 
 result = abs(covMatrix(1,2)/(std(x)*std(y)));