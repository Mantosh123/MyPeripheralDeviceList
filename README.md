# Bluetooth Basics
BluetoothCurrentStatusDemo is the used to see current status of bluetooth 

## Usage

### To Show Peripheral Device List

```swift
Using CBCentralManagerDelegate and CBPeripheralDelegate for get Peripheral Device List

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("peripheral:- \(peripheral)")
    }
    
```


## License

BluetoothCurrentStatusDemo is public to use.
