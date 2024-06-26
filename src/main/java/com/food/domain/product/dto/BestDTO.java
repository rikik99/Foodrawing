package com.food.domain.product.dto;

public class BestDTO {
    private int orderId;
    private int salesPostId;
    private int unitPrice;
    private int discountPrice;
    private int orderQuantity;
    private String salesPostTitle;
    private String salesPostDescription;
    private String filePath;
    private String fileType;

    // Getters and setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getSalesPostId() {
        return salesPostId;
    }

    public void setSalesPostId(int salesPostId) {
        this.salesPostId = salesPostId;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(int discountPrice) {
        this.discountPrice = discountPrice;
    }

    public int getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(int orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public String getSalesPostTitle() {
        return salesPostTitle;
    }

    public void setSalesPostTitle(String salesPostTitle) {
        this.salesPostTitle = salesPostTitle;
    }

    public String getSalesPostDescription() {
        return salesPostDescription;
    }

    public void setSalesPostDescription(String salesPostDescription) {
        this.salesPostDescription = salesPostDescription;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }
}
