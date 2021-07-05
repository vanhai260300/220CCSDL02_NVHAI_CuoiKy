install.packages("rvest")
install.packages("dplyr")
install.packages("selectr")
install.packages("xml2")
install.packages("stringr")
install.packages("jsonlite")
install.packages("writexl")
install.packages("xlsx")

library("xlsx")
library("rvest")
library("dplyr")
library("selectr")
library("xml2")
library("stringr")
library("jsonlite")
library("writexl")

#a vector of urls you want to scrape
mainurl<-'https://mobilecity.vn/dien-thoai'
mobilecyty<- read_html(mainurl)

#Lay Category cua Product
titleCategory_html <- html_nodes(mobilecyty,".product-fillter-box .filter-column li a")
titlecategory <- html_text(titleCategory_html)
ttcg<-str_replace_all(titlecategory, "[\n]","")

linkCategory_html <- html_attr(html_nodes(mobilecyty,".filter-column li a"),"href")


print(length(ttcg))
print(length(linkCategory_html))

#Create idCategory
arrCode <- rep(1)
for (i in 2:length(ttcg))
{
  arrCode<-append(arrCode,i)
}

#DataFrame cua Table Category
categorydata <- data.frame(Code = arrCode, Title=ttcg , LinkCategory = linkCategory_html)
dataftcategory <- filter(categorydata, Code != 1)
nrow(dataftcategory)
dataftcategory[3]

#Luu Category vao Excel
write.xlsx(dataftcategory,"D:/BAITAP/20HK2/CDCSDL/CuoiKy/DataProduct.xlsx",sheetName = "Category",row.names = FALSE,append = TRUE)

#Khoi tao Frame rong cho Product va Product Detail
datafeAll = data.frame()
datafeAllDetail = data.frame()

#Cho vong lap for chay tu 1 - So hang cua Category
for(i in 20:(nrow(dataftcategory)))
{ 
  #print(i)
  #print(dataftcategory[i,3])
  #lay Link cua cac trang Product de vao trang DEtail Product
  htmllink.obj <- read_html(dataftcategory[i,3])
  linkk_html1 <- html_attr(html_nodes(htmllink.obj,".product-list .product-list-item .product-item-image a"),"href")
  Link_product_data<-data.frame(Title = linkk_html1)
  
  #Trong cac link do co cac link thua n?n can loai bo
  library("dplyr")
  dataftProduct <- filter(Link_product_data, Title != "/page/chinh-sach-bao-hanh.html")
  #IN Link cua cac trang Product de vao trang DEtail Product
  print(dataftProduct)
  
  for(j in dataftProduct)
  {
    
    #Data Product
    dafProduct <- lapply(j, function(u){
      #Ten San Pham
      html.obj1 <- read_html(u)
      title_html <- html_nodes(html.obj1,"h1.title")
      title <- html_text(title_html)
      t<-str_replace_all(title, "[\n]","")
      #Hinh Anh
      img_html <- html_attr(html_nodes(html.obj1,".product-content-box .product-slide-image .product_image .active img"),"src")
      
      #Gia Ca
      price_html <- html_nodes(html.obj1,".price-and-color .price")
      price <- html_text(price_html)
      p<-str_replace_all(price, "[\n]","")
      print(price_html)
      
      #So sao / 5
      rate_html <- html_nodes(html.obj1,".comment-box .comment-vote .comment-vote__star .comment-vote__star-number")
      rate <- html_text(rate_html)
      r<-str_replace_all(rate, "[\n]","")
      
      #So luong danh gia
      quanrate_html <- html_nodes(html.obj1,".product-title .rating-show-start .rating-show-count span")
      quanrate <- html_text(quanrate_html)
      qr<-str_replace_all(quanrate, "[\n]","")
      
      #print(codeCategory)
      #codeCategory = dataftcategory[i,1] La ID cua Category Môi San pham deu co ID nay
      data.frame(NameProduct = t, codeCategory = dataftcategory[i,1] ,Image = img_html , Price=p ,Rate = r, QuanRate = qr)
    }) 
    
    #Data Product Detail
    dafDetail <- lapply(j, function(u){
      html.obj2 <- read_html(u)
      # Man Hinh
      Screen_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(1) td:nth-child(2)"
        )
      Screen <- html_text(Screen_html)
      sc <- str_replace_all(Screen, "[\n]", "")
      #He Dieu Hanh
      ops_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(2) td:nth-child(2)"
        )
      ops <- html_text(ops_html)
      op <- str_replace_all(ops, "[\n]", "")
      #Camera Truoc
      Rearcamera_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(3) td:nth-child(2)"
        )
      RearCamera <- html_text(Rearcamera_html)
      rec <- str_replace_all(RearCamera, "[\n]", "")
      #Camera Sau
      FrontCamera_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(4) td:nth-child(2)"
        )
      FrontCamera <- html_text(FrontCamera_html)
      frc <- str_replace_all(FrontCamera, "[\n]", "")
      #CPU
      cpu_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(5) td:nth-child(2)"
        )
      cpu <- html_text(cpu_html)
      cp <- str_replace_all(cpu, "[\n]", "")
      #RAM
      ram_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(6) td:nth-child(2)"
        )
      ram <- html_text(ram_html)
      ram <- str_replace_all(ram, "[\n]", "")
      #Bo nho trong
      Internalmemory_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(7) td:nth-child(2)"
        )
      Internalmemory <- html_text(Internalmemory_html)
      Internalmemory <- str_replace_all(Internalmemory, "[\n]", "")
      #SIM
      sim_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(8) td:nth-child(2)"
        )
      sim <- html_text(sim_html)
      sim <- str_replace_all(sim, "[\n]", "")
      #Dung Luong Pin
      Battery_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(9) td:nth-child(2)"
        )
      Battery <- html_text(Battery_html)
      Battery <- str_replace_all(Battery, "[\n]", "")
      #Thiet ke
      design_html <-
        html_nodes(
          html.obj2,
          ".product-content-box .product-info-box .product-info-content table tbody tr:nth-child(10) td:nth-child(2)"
        )
      design <- html_text(design_html)
      design <- str_replace_all(design, "[\n]", "")
      
      #data.frame(Title=t,img=img_html, Price=p , Rate = r, QuanRate = qr)
      data.frame(
        Screenn = sc ,
        oprating = op ,
        ReCam = rec ,
        FrCam = frc,
        CPU = sc ,
        RAM = op ,
        Internalmemory = Internalmemory ,
        SIM = sim,
        Battery = Battery ,
        Design = design
      )
    })
  }
  
  #Noi tat ca dataframe
  datafeAllALink <-do.call(rbind, dafProduct)
  datafeAllALinkDetail <-do.call(rbind, dafDetail)
  #Noi cac dataFrame sau moi vong lap For
  datafeAll<- rbind(datafeAll,datafeAllALink)
  datafeAllDetail<- rbind(datafeAllDetail,datafeAllALinkDetail)
  #Dem vong lap
  print("---------------VONG THU : ")
  print(i)
}
#Gan du lieu vong lap sang Frame moi
datafeAll2 <- datafeAll
datafeAllDetail2 <- datafeAllDetail
#Lay so hang cua moi Frame
print("Prosucts : ")
print(nrow(datafeAll2))
print("Prosucts Detail : ")
print(nrow(datafeAllDetail2))
#Set ID cho bang Product va Product Detail
dataProductFinal <- cbind(idProduct=1:(nrow(datafeAll2)),datafeAll2)
dataProductDetailFinal <- cbind(idProduct=1:(nrow(datafeAllDetail2)),datafeAllDetail2)

dataProductDetailFinal
#Lua data vao Excel
write.xlsx(dataProductFinal,"D:/BAITAP/20HK2/CDCSDL/CuoiKy/DataProduct.xlsx",sheetName = "Product",row.names = FALSE,append = TRUE)
write.xlsx(dataProductDetailFinal,"D:/BAITAP/20HK2/CDCSDL/CuoiKy/DataProduct.xlsx",sheetName = "ProductDetail",row.names = FALSE,append = TRUE)



















