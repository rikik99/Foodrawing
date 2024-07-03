package com.food.domain.product.dto;

public class BestDTO {
    private int salesPostId;
    private int unitPrice;
    private int orderQuantity;
    private String salesPostTitle;
    private String salesPostDescription;
    private String filePath;

    // Getters and setters
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
}
