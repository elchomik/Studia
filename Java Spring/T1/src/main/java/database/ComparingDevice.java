package database;

import java.util.Objects;

public record ComparingDevice(String manufacturer, String touch, String screenSize, String screenResolution,
                              String screenType, String processorName, int physicalCores, int clockSpeed, String ram,
                              String discType, String discStorage, String graphicCardName, String graphicCardMemory,
                              String os, String discReader) {

    @Override
    public String toString() {
        return "ComparingDevice{" +
                "manufacturer='" + manufacturer + '\'' +
                ", touch='" + touch + '\'' +
                ", screenSize='" + screenSize + '\'' +
                ", screenResolution='" + screenResolution + '\'' +
                ", screenType='" + screenType + '\'' +
                ", processorName='" + processorName + '\'' +
                ", physicalCores=" + physicalCores +
                ", clockSpeed=" + clockSpeed +
                ", ram='" + ram + '\'' +
                ", discType='" + discType + '\'' +
                ", discStorage='" + discStorage + '\'' +
                ", graphicCardName='" + graphicCardName + '\'' +
                ", graphicCardMemory='" + graphicCardMemory + '\'' +
                ", os='" + os + '\'' +
                ", discReader='" + discReader + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ComparingDevice that = (ComparingDevice) o;
        return physicalCores == that.physicalCores && clockSpeed == that.clockSpeed && Objects.equals(manufacturer, that.manufacturer) && Objects.equals(touch, that.touch) && Objects.equals(screenSize, that.screenSize) && Objects.equals(screenResolution, that.screenResolution) && Objects.equals(screenType, that.screenType) && Objects.equals(processorName, that.processorName) && Objects.equals(ram, that.ram) && Objects.equals(discType, that.discType) && Objects.equals(discStorage, that.discStorage) && Objects.equals(graphicCardName, that.graphicCardName) && Objects.equals(graphicCardMemory, that.graphicCardMemory) && Objects.equals(os, that.os) && Objects.equals(discReader, that.discReader);
    }

}
