//
//  ViewController.swift
//  MyPeripheralDeviceList
//
//  Created by Mantosh Kumar on 13/06/24.
//

import UIKit
import CoreBluetooth

struct ScandPeripheral {
    var name: String?
    var identifire: UUID?
    var state: CBPeripheralState?
    var sPeripheral: CBPeripheral?
    
    init(name: String? = nil, identifire: UUID? = nil, state: CBPeripheralState? = nil, sPeripheral: CBPeripheral? = nil) {
        self.name = name
        self.identifire = identifire
        self.state = state
        self.sPeripheral = sPeripheral
    }
}

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bluetoothStatusLabel: UILabel!
    
    var centeralManager: CBCentralManager!
    var myPeripheral: CBPeripheral!
    
    var scanedPeripheralList: [ScandPeripheral] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Peripheral list"
        centeralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStatusBarBGColor()
    }
    
    private func setStatusBarBGColor () {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        // https://stackoverflow.com/a/57899013/7316675
        let statusBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        statusBar.backgroundColor = .orange
        window?.addSubview(statusBar)
        navigationController?.navigationBar.backgroundColor = .orange
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == CBManagerState.poweredOn {
            bluetoothStatusLabel.text = "Bluetooth is ON"
        } else {
            print(" Please check your bluetooth connect")
            bluetoothStatusLabel.text = "Bluetooth is OFF"
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("peripheral:- \(peripheral)")
        
        var scanPeripheral = ScandPeripheral(name: peripheral.name ?? "unknown Device", identifire: peripheral.identifier, state: peripheral.state, sPeripheral: peripheral)
        
        //if (self.scanedPeripheralList.contains(scanPeripheral)) {
        scanedPeripheralList.append(scanPeripheral)
        //}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func scanAction(_ sender: Any) {
        centeralManager.scanForPeripherals(withServices: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scanedPeripheralList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeripheralCell") as! PeripheralCell
        cell.nameLabel.text = scanedPeripheralList[indexPath.row].name
        return cell
    }
}

