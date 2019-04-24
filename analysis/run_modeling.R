# 2017 06 08 I.Zliobaite

input_all <- 'data_input/data_sites_processed.csv'
file_data <- 'data_input/data_sites_ref_global.csv'

#parameters and colors for plotting
wd <- 8 #was15
ht <- 4.2 #was7
cxax <- 0.7 #was1
cxpt <- 1 #was 1.5
cxdo <- 0.1 #was0.4 and 0.35
mycol <- c('#1f78b4','#a65628','gold','#b2df8a','#e41a1c','#016c59')
mycol_Turkana <- c('#016c59','#98A959','#FFD700','#FFC864','#FF8700','#e41a1c')
mycol_Kop <- c('#e41a1c','#b2df8a','gold','#016c59','gray20','#a65628','#1f78b4')

#reading input data
data_ref <- read.csv(file_data, header = TRUE, sep = '\t')
data_all <- read.csv(input_all, header = TRUE, sep = '\t')

#filtering data 

ind <- which(data_all[,'elevation']<2500) #removing high elevation
data_all <- data_all[ind,]

ind <- which(data_all[,'no_species']>=3) #must have at least three species
data_all <- data_all[ind,]

ind <- which(data_all[,'bio1new'] > (-8000)) #removing entries with missing values
data_all <- data_all[ind,]

ind <- which(data_all[,'evo'] > (-8000)) #removing entries with missing values
data_all <- data_all[ind,]

ind <- which(data_all[,'bio12new'] > 3000) #precipitation cap
data_all[ind,'bio12new'] <- 3000


#regressions

fit_MAT <- lm(bio1new ~ FCT_AL, data=data_all)
print('Equation (2)')
print(summary(fit_MAT))
fit_MINT <- lm(bio6new ~ FCT_AL, data=data_all)
print('Equation (3)')
print(summary(fit_MINT))
fit_MAP <- lm(bio12new ~ HYP + LOP, data=data_all)
print('Equation (4)')
print(summary(fit_MAP))
fit_NPP <- lm(bio20new ~ HYP + LOP, data=data_all)
print('Equation (5)')
print(summary(fit_NPP))

#plots

pdf('plots/fig_map_MAT_model.pdf',width = 11,height = 7)
plot(data_all[,'lon_bio'],data_all[,'lat_bio'],pch=20,cex = 0.2)
dev.off()

pdf('plots/fig_HYP.pdf',width = wd,height = ht)
rbPal <- colorRampPalette(c('black','darkgreen','gold','orange'))
pcol <- rbPal(12)[as.numeric(cut(c(data_all[,'HYP'],1,3),breaks = 12))]
pcol <- pcol[1:(length(pcol)-2)]
plot(data_ref[,'land_lon'],data_ref[,'land_lat'],col='grey95',pch=20,cex = cxdo,xaxt='n',yaxt='n',ann=FALSE)
points(data_all[,'lon_bio'],data_all[,'lat_bio'],pch=20,cex =cxdo,col = pcol)
legend("bottomleft",legend=seq(1,3,by=0.5),col=rbPal(5),pch=15,cex = cxax,pt.cex = cxpt,title = 'HYP')
dev.off()

pdf('plots/fig_LOP.pdf',width = wd,height = ht)
rbPal <- colorRampPalette(c('black','darkgreen','gold','orange'))
pcol <- rbPal(12)[as.numeric(cut(c(data_all[,'LOP'],0,2),breaks = 12))]
pcol <- pcol[1:(length(pcol)-2)]
plot(data_ref[,'land_lon'],data_ref[,'land_lat'],col='grey95',pch=20,cex = 0.4,xaxt='n',yaxt='n',ann=FALSE)
points(data_all[,'lon_bio'],data_all[,'lat_bio'],pch=20,cex = 0.35,col = pcol)
legend("bottomleft",legend=seq(0,2,by=0.5),col=rbPal(5),pch=15,cex = cxax,pt.cex = cxpt,title = 'LOP')
dev.off()

pdf('plots/fig_AL.pdf',width = wd,height = ht)
rbPal <- colorRampPalette(c('gold','darkgreen','black'))
pcol <- rbPal(12)[as.numeric(cut(c(data_all[,'FCT_AL'],0,1),breaks = 12))]
pcol <- pcol[1:(length(pcol)-2)]
plot(data_ref[,'land_lon'],data_ref[,'land_lat'],col='grey95',pch=20,cex =cxdo,xaxt='n',yaxt='n',ann=FALSE)
points(data_all[,'lon_bio'],data_all[,'lat_bio'],pch=20,cex = cxdo,col = pcol)
legend("bottomleft",legend=seq(0,1,by=0.2),col=rbPal(6),pch=15,cex = cxax,pt.cex = cxpt,title = 'AL')
dev.off()

pdf('plots/fig_PREC.pdf',width = wd,height = ht)
#rbPal <- colorRampPalette(c('black','darkgreen','gold',''))
rbPal <- colorRampPalette(c('gold','darkgreen'))
pcol <- rbPal(20)[as.numeric(cut(c(data_all[,'bio12new'],0,3000),breaks = 20))]
pcol <- pcol[1:(length(pcol)-2)]
plot(data_ref[,'land_lon'],data_ref[,'land_lat'],col='grey95',pch=20,cex = cxdo,xaxt='n',yaxt='n',ann=FALSE)
points(data_all[,'lon_bio'],data_all[,'lat_bio'],pch=20,cex = cxdo,col = pcol)
legend("bottomleft",legend=seq(0,3000,by=500),col=rbPal(7),pch=15,cex = cxax,pt.cex = cxpt,title = 'MAP')
dev.off()

pdf('plots/fig_NPP.pdf',width = wd,height = ht)
#rbPal <- colorRampPalette(c('black','darkgreen','gold','orange'))
rbPal <- colorRampPalette(c('gold','darkgreen'))
pcol <- rbPal(20)[as.numeric(cut(c(data_all[,'bio20new'],0,3000),breaks = 20))]
pcol <- pcol[1:(length(pcol)-2)]
plot(data_ref[,'land_lon'],data_ref[,'land_lat'],col='grey95',pch=20,cex = cxdo,xaxt='n',yaxt='n',ann=FALSE)
points(data_all[,'lon_bio'],data_all[,'lat_bio'],pch=20,cex = cxdo,col = pcol)
legend("bottomleft",legend=seq(0,3000,by=500),col=rbPal(7),pch=15,cex = cxax,pt.cex = cxpt,title = 'NPP')
dev.off()

pdf('plots/fig_TEMP.pdf',width = wd,height = ht)
#rbPal <- colorRampPalette(c('blue','yellow','red'))
rbPal <- colorRampPalette(c('black','darkgreen','gold'))
dbb <- data_all[,'bio1new']
ind <- which(dbb>30)
dbb[ind] <- 30
pcol <- rbPal(20)[as.numeric(cut(c(dbb,-20,30),breaks = 20))]
pcol <- pcol[1:(length(pcol)-2)]
plot(data_ref[,'land_lon'],data_ref[,'land_lat'],col='grey95',pch=20,cex = cxdo,xaxt='n',yaxt='n',ann=FALSE)
points(data_all[,'lon_bio'],data_all[,'lat_bio'],pch=20,cex = cxdo,col = pcol)
legend("bottomleft",legend=seq(-20,30,by=10),col=rbPal(6),pch=15,cex = cxax,pt.cex = cxpt,title = 'MAT')
dev.off()
