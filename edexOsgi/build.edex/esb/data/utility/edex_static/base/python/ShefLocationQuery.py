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

from java.util import ArrayList
from com.raytheon.edex.uengine.tasks.query import ShefQuery

#
# XML request of data
#
#    
#     SOFTWARE HISTORY
#    
#    Date            Ticket#       Engineer       Description
#    ------------    ----------    -----------    --------------------------
#    06/02/08                      M. Duff        Initial Creation.
#    
# 
class ShefLocationQuery(BaseRequest.BaseRequest):
    
    def __init__(self):
        BaseRequest.BaseRequest.__init__(self, "")
        self.queryResults = None        
        self.query = ShefQuery()
        
        
    