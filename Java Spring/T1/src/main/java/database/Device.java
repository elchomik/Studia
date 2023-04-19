package database;

import java.util.List;
import java.util.Objects;

public record Device(int id, String manufacturer, String touch, String screenSize, String screenResolution,
                     String screenType, String processorName, int physicalCores, int clockSpeed, String ram,
                     String discType, String discStorage, String graphicCardName, String graphicCardMemory, String os,
                     String discReader) {

    public static ComparingDevice toComparingDevice(Device device) {
        return new ComparingDevice(device.manufacturer, device.touch, device.screenSize,
                device.screenResolution, device.screenType, device.processorName, device.physicalCores,
                device.clockSpeed, device.ram, device.discType, device.discStorage, device.graphicCardName,
                device.graphicCardMemory, device.os, device.discReader);
    }

    public static List<ComparingDevice> toComparingDevices(List<Device> devices) {
        return devices.stream().map(Device::toComparingDevice).toList();
    }

    public static Device toDevice(ComparingDevice comparingDevice, int id) {
        return new Device(id, comparingDevice.manufacturer(), comparingDevice.touch(),
                comparingDevice.screenSize(), comparingDevice.screenResolution(),
                comparingDevice.screenType(), comparingDevice.processorName(),
                comparingDevice.physicalCores(), comparingDevice.clockSpeed(),
                comparingDevice.ram(), comparingDevice.discType(), comparingDevice.discStorage(),
                comparingDevice.graphicCardName(), comparingDevice.graphicCardMemory(),
                comparingDevice.os(), comparingDevice.discReader());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Device device = (Device) o;
        return physicalCores == device.physicalCores && clockSpeed == device.clockSpeed && Objects.equals(manufacturer, device.manufacturer) && Objects.equals(touch, device.touch) && Objects.equals(screenSize, device.screenSize) && Objects.equals(screenResolution, device.screenResolution) && Objects.equals(screenType, device.screenType) && Objects.equals(processorName, device.processorName) && Objects.equals(ram, device.ram) && Objects.equals(discType, device.discType) && Objects.equals(discStorage, device.discStorage) && Objects.equals(graphicCardName, device.graphicCardName) && Objects.equals(graphicCardMemory, device.graphicCardMemory) && Objects.equals(os, device.os) && Objects.equals(discReader, device.discReader);
    }

    @Override
    public int hashCode() {
        return Objects.hash(manufacturer, touch, screenSize, screenResolution, screenType, processorName, physicalCores, clockSpeed, ram, discType, discStorage, graphicCardName, graphicCardMemory, os, discReader);
    }
}
