##
# This software was developed and / or modified by Raytheon Company,
# pursuant to Contract DG133W-05-CQ-1067 with the US Government.
# 
# U.S. EXPORT CONTROLLED TECHNICAL DATA
# This software product contains export-restricted data whose
# export/transfer/disclosure is restricted by U.S. law. Dissemination
# to non-U.S. persons whether in the United States or abroad requires
# an export license or other authorization.
# 
# Contractor Name:        Raytheon Company
# Contractor Address:     6825 Pine Street, Suite 340
#                         Mail Stop B8
#                         Omaha, NE 68106
#                         402.291.0100
# 
# See the AWIPS II Master Rights File ("Master Rights File.pdf") for
# further licensing information.
##
# ----------------------------------------------------------------------------
# This software is in the public domain, furnished "as is", without technical
# support, and with no warranty, express or implied, as to its usefulness for
# any purpose.
#
# CivilEmerg_TestScript
#
# Author:
# ----------------------------------------------------------------------------

scripts = [
    {"name":"ADR1",
     "productType" : "CivilEmerg_ADR_Local",
     "commentary": "Basic ADMINISTRATIVE MESSAGE formatter test",
     "checkStrings" : ["ADMINISTRATIVE MESSAGE"],
     },
    {"name":"ADR2", 
     "productType" : "CivilEmerg_ADR_Local",
     "commentary": "Different Options ADMINISTRATIVE MESSAGE formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","ADMINISTRATIVE MESSAGE"],
     },    
    {"name":"AVA1", 
     "productType" : "CivilEmerg_AVA_Local",
     "commentary": "Basic AVALANCHE WATCH formatter test",
     "checkStrings" : ["AVALANCHE WATCH"],
     },
    {"name":"AVA2", 
     "productType" : "CivilEmerg_AVA_Local",
     "commentary": "Different Options AVALANCHE WATCH formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","AVALANCHE WATCH"],
     },
    {"name":"AVW1",  
     "productType" : "CivilEmerg_AVW_Local",
     "commentary": "Basic AVALANCHE WARNING formatter test",
     "checkStrings" : ["AVALANCHE WARNING"],
     },
    {"name":"AVW2",  
     "productType" : "CivilEmerg_AVW_Local",
     "commentary": "Different Options AVALANCHE WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","AVALANCHE WARNING"],
     },
    {"name":"CAE1",  
     "productType" : "CivilEmerg_CAE_Local",
     "commentary": "Basic CHILD ABDUCTION EMERGENCY formatter test",
     "checkStrings" : ["CHILD ABDUCTION EMERGENCY"],
     },
    {"name":"CAE2",  
     "productType" : "CivilEmerg_CAE_Local",
     "commentary": "Different Options CHILD ABDUCTION EMERGENCY formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","CHILD ABDUCTION EMERGENCY"],
     },
    {"name":"CDW1",  
     "productType" : "CivilEmerg_CDW_Local",
     "commentary": "Basic CIVIL DANGER WARNING formatter test",
     "checkStrings" : ["CIVIL DANGER WARNING"],
     },
    {"name":"CDW2",  
     "productType" : "CivilEmerg_CDW_Local",
     "commentary": "Different Options CIVIL DANGER WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","CIVIL DANGER WARNING"],
     },
    {"name":"CEM1",  
     "productType" : "CivilEmerg_CEM_Local",
     "commentary": "Basic CIVIL EMERGENCY MESSAGE formatter test",
     "checkStrings" : ["CIVIL EMERGENCY MESSAGE"],
     },
    {"name":"CEM2",  
     "productType" : "CivilEmerg_CEM_Local", 
     "commentary": "Different Options CIVIL EMERGENCY MESSAGE formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","CIVIL EMERGENCY MESSAGE"],
     },
    {"name":"EQR1",  
     "productType" : "CivilEmerg_EQR_Local",
     "commentary": "EARTHQUAKE REPORT formatter test",
     "cmdLineVars": "{('Damage', 'damage'): 'CONSIDERABLE', ('Official Earthquake Info Source:', 'eqInfo'): 'GOLDEN', ('Felt:', 'felt'): 'MODERATELY', ('How Many Reports:', 'extent'): 'MANY PEOPLE', ('Damage Type', 'damageType'): ['CRACKED CHIMNEYS'], ('Issued By', 'issuedBy'): None, ('Issuance Type', 'issuanceType'): 'PRELIMINARY'}",
     "checkStrings": [
       "EARTHQUAKE REPORT", 
       "AN EARTHQUAKE HAS BEEN FELT MODERATELY BY MANY PEOPLE",
       "CONSIDERABLE DAMAGE HAS BEEN REPORTED",
       "DAMAGE REPORTS SO FAR...CRACKED CHIMNEYS",
       ],
     },
    {"name":"EQW1",  
     "productType" : "CivilEmerg_EQW_Local",
     "commentary": "Basic EARTHQUAKE WARNING formatter test",
     "checkStrings" : ["EARTHQUAKE WARNING"],
     },
    {"name":"EQW2",  
     "productType" : "CivilEmerg_EQW_Local", 
     "commentary": "Different Options EARTHQUAKE WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","EARTHQUAKE WARNING"],
     },
    {"name":"EVI1",  
     "productType" : "CivilEmerg_EVI_Local",
     "commentary": "Basic EVACUATION IMMEDIATE formatter test",
     "checkStrings" : ["EVACUATION IMMEDIATE"],
     },
    {"name":"EVI2",  
     "productType" : "CivilEmerg_EVI_Local", 
     "commentary": "Different Options EVACUATION IMMEDIATE formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","EVACUATION IMMEDIATE"],
     },
    {"name":"FRW1",  
     "productType" : "CivilEmerg_FRW_Local",
     "commentary": "Basic FIRE WARNING formatter test",
     "checkStrings" : ["FIRE WARNING"],
     },
    {"name":"FRW2",  
     "productType" : "CivilEmerg_FRW_Local", 
     "commentary": "Different Options FIRE WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","FIRE WARNING"]},
    {"name":"HMW1",  
     "productType" : "CivilEmerg_HMW_Local",
     "commentary": "Basic HAZARDOUS MATERIAL WARNING formatter test",
     "checkStrings" : ["HAZARDOUS MATERIAL WARNING"],
     },
    {"name":"HMW2",  
     "productType" : "CivilEmerg_HMW_Local", 
     "commentary": "Different Options HAZARDOUS MATERIAL WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","HAZARDOUS MATERIAL WARNING"],
     },
    {"name":"LAE1",  
     "productType" : "CivilEmerg_LAE_Local",
     "commentary": "Basic LOCAL AREA EMERGENCY formatter test",
     "checkStrings" : ["LOCAL AREA EMERGENCY"],
     },
    {"name":"LAE2",  
     "productType" : "CivilEmerg_LAE_Local", 
     "commentary": "Different Options LOCAL AREA EMERGENCY formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","LOCAL AREA EMERGENCY"],
     },
    {"name":"LEW1",  
     "productType" : "CivilEmerg_LEW_Local",
     "commentary": "Basic LAW ENFORCEMENT WARNING formatter test",
     "checkStrings" : ["LAW ENFORCEMENT WARNING"],
     },
    {"name":"LEW2",  
     "productType" : "CivilEmerg_LEW_Local", 
     "commentary": "Different Options LAW ENFORCEMENT WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","LAW ENFORCEMENT WARNING"],
     },
    {"name":"NUW1",  
     "productType" : "CivilEmerg_NUW_Local",
     "commentary": "Basic NUCLEAR POWER PLANT WARNING formatter test",
     "checkStrings" : ["NUCLEAR POWER PLANT WARNING"],
     },
    {"name":"NUW2",  
     "productType" : "CivilEmerg_NUW_Local", 
     "commentary": "Different Options NUCLEAR POWER PLANT WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","NUCLEAR POWER PLANT WARNING"],
     },
    {"name":"RHW1",  
     "productType" : "CivilEmerg_RHW_Local",
     "commentary": "Basic RADIOLOGICAL HAZARD WARNING formatter test",
     "checkStrings" : ["RADIOLOGICAL HAZARD WARNING"],
     },
    {"name":"RHW2",  
     "productType" : "CivilEmerg_RHW_Local",
     "commentary": "Different Options RADIOLOGICAL HAZARD WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","RADIOLOGICAL HAZARD WARNING"],
     },
    {"name":"SPW1",  
     "productType" : "CivilEmerg_SPW_Local",
     "commentary": "Basic SHELTER IN PLACE WARNING formatter test",
     "checkStrings" : ["SHELTER IN PLACE WARNING"],
     },
    {"name":"SPW2",  
     "productType" : "CivilEmerg_SPW_Local",
     "commentary": "Different Options SHELTER IN PLACE WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","SHELTER IN PLACE WARNING"],
     },
    {"name":"TOE1",  
     "productType" : "CivilEmerg_TOE_Local",
     "commentary": "Basic 911 TELEPHONE OUTAGE EMERGENCY formatter test",
     "checkStrings" : ["911 TELEPHONE OUTAGE EMERGENCY"],
     },
    {"name":"TOE2",  
     "productType" : "CivilEmerg_TOE_Local", 
     "commentary": "Different Options 911 TELEPHONE OUTAGE EMERGENCY formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","911 TELEPHONE OUTAGE EMERGENCY"],
     },
    {"name":"VOW1",  
     "productType" : "CivilEmerg_VOW_Local",
     "commentary": "Basic VOLCANO WARNING formatter test",
     "checkStrings" : ["VOLCANO WARNING"],
     },
    {"name":"VOW2",  
     "productType" : "CivilEmerg_VOW_Local", 
     "commentary": "Different Options VOLCANO WARNING formatter test",
     "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'BULLETIN - EAS ACTIVATION REQUESTED'}",
     "checkStrings" : ["BULLETIN - EAS ACTIVATION REQUESTED","VOLCANO WARNING"],
     },
    ]

import TestScript
def testScript(self, dataMgr):
    defaults = {
        "cmdLineVars" :"{('Source', 'source'): 'COLORADO EMERGENCY MANAGEMENT AGENCY DENVER COLORADO', ('Issued By', 'issuedBy'): None, ('EAS Level', 'eas'): 'NONE'}",
        "comboFlag": 1,
        "combinations": "ZONE",
        "deleteGrids": [("Fcst", "Hazards", "SFC", "all", "all")],
        "gridsStartTime": "20090731_1400",
        "orderStrings": 1,
        }
    return TestScript.generalTestScript(self, dataMgr, scripts, defaults)



