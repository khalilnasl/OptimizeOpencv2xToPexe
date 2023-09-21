//
// Copyright (C) 2008 Christoph Sommer <christoph.sommer@informatik.uni-erlangen.de>
// Copyright (C) 2020 Piermaria Arvani <piermaria.arvani@gmail.com>
//
// Documentation for these modules is at http://veins.car2x.org/
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//

package org.car2x.plexe.subprojects.plexe_cv2x;

import org.car2x.veins.base.modules.IBaseApplLayer;
import org.car2x.veins.modules.mobility.traci.TraCIMobility;
import org.car2x.veins.modules.nic.Nic80211p;

import org.car2x.plexe.utilities.BasePositionHelper;
//import org.car2x.plexe.scenarios.BaseScenario;
import org.car2x.plexe.protocols.BaseProtocol;
//import org.car2x.plexe.protocols.SimplePlatooningBeaconingHuman;

//import org.car2x.plexe.protocols.HumanInterferingProtocol;
import org.car2x.plexe.apps.BaseApp;

import org.car2x.plexe.subprojects.plexe_cv2x.Mode4NodeRegistrar;
import org.car2x.plexe.subprojects.plexe_cv2x.Mode4RadioDriver;

import lte.stack.phy.ILteNic;
import inet.mobility.contract.IMobility;


module HumanCar
{
    parameters:
        @display("p=90,100");
        @networkNode;
        //string scenario_type;
        string helper_type;
        //string appl_type;
        string protocol_type;


        string nicType = default("LteNicVUeMode4");
        int macNodeId = default(0);
        int masterId = default(0);

        //# D2D capability
        bool d2dCapable = default(true);
        bool mode4D2D = default(true);
        string mobilityType = default("VeinsInetMobility");


    gates:
        input radioIn; // gate for sendDirect
    submodules:

        helper: <helper_type> like BasePositionHelper {
            parameters:
                @display("p=90,100");
        }

       // scenario: <scenario_type> like BaseScenario {
           // parameters:
               // @display("p=90,100");
       // }

        //appl: <appl_type> like BaseApp {
            //parameters:
                //@display("p=60,100");
        //}

        prot: <protocol_type> like BaseProtocol {
            parameters:
                @display("p=150,222");
        }


        lteNic: <nicType> like ILteNic {
            @display("p=150,400");
            nodeType = "UE";
        }

        mobility: <mobilityType> like IMobility {
            parameters:
                @display("p=242,125;i=block/cogwheel");
        }

        traciMobility: TraCIMobility {
            parameters:
                x = 0;
                y = 0;
                z = 1.895;
                @display("p=234,61;i=block/cogwheel");
        }

        radioDriver: Mode4RadioDriver {
            parameters:
                @display("p=150,309");
        }

        mode4NodeRegistrar: Mode4NodeRegistrar {
            parameters:
                @display("p=166,139");
        }
    connections allowunconnected:
        radioDriver.upperLayerIn <-- prot.lowerLayerOut;
        radioDriver.upperLayerOut --> prot.lowerLayerIn;
        radioDriver.lowerLayerOut --> lteNic.upperLayerIn;
        radioDriver.lowerLayerIn <-- lteNic.upperLayerOut;
        radioIn --> lteNic.radioIn;

}
