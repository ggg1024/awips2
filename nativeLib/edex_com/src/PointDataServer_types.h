/*****************************************************************************************
 * COPYRIGHT (c), 2009, RAYTHEON COMPANY
 * ALL RIGHTS RESERVED, An Unpublished Work
 *
 * RAYTHEON PROPRIETARY
 * If the end user is not the U.S. Government or any agency thereof, use
 * or disclosure of data contained in this source code file is subject to
 * the proprietary restrictions set forth in the Master Rights File.
 *
 * U.S. GOVERNMENT PURPOSE RIGHTS NOTICE
 * If the end user is the U.S. Government or any agency thereof, this source
 * code is provided to the U.S. Government with Government Purpose Rights.
 * Use or disclosure of data contained in this source code file is subject to
 * the "Government Purpose Rights" restriction in the Master Rights File.
 *
 * U.S. EXPORT CONTROLLED TECHNICAL DATA
 * Use or disclosure of data contained in this source code file is subject to
 * the export restrictions set forth in the Master Rights File.
 ******************************************************************************************/

/*
 * Support for point data request capability to retrieve point data and metadata
 * from EDEX Thrift service.
 *
 * <pre>
 *
 * SOFTWARE HISTORY
 *
 * Date         Ticket#     Engineer    Description
 * ------------ ----------  ----------- --------------------------
 * 08/08/11     9696        gzhou       Initial Creation
 *
 * </pre>
 *
 * @author gzhou
 * @version 1
 */

/**
 * Autogenerated by Thrift
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 */
#ifndef PointDataServer_TYPES_H
#define PointDataServer_TYPES_H

#include <Thrift.h>
#include <TApplicationException.h>
#include <protocol/TProtocol.h>
#include <transport/TTransport.h>
#include "PointData_types.h"





typedef struct _com_raytheon_uf_common_dataquery_requests_ConstraintType__isset {
  _com_raytheon_uf_common_dataquery_requests_ConstraintType__isset() : operand(false) {}
  bool operand;
} _com_raytheon_uf_common_dataquery_requests_ConstraintType__isset;

class com_raytheon_uf_common_dataquery_requests_ConstraintType {
 public:

  static const char* ascii_fingerprint; // = "EFB929595D312AC8F305D5A794CFEDA1";
  static const uint8_t binary_fingerprint[16]; // = {0xEF,0xB9,0x29,0x59,0x5D,0x31,0x2A,0xC8,0xF3,0x05,0xD5,0xA7,0x94,0xCF,0xED,0xA1};

  com_raytheon_uf_common_dataquery_requests_ConstraintType() : operand("") {
  }

  virtual ~com_raytheon_uf_common_dataquery_requests_ConstraintType() throw() {}

  std::string operand;

  _com_raytheon_uf_common_dataquery_requests_ConstraintType__isset __isset;

  bool operator == (const com_raytheon_uf_common_dataquery_requests_ConstraintType & rhs) const
  {
    if (!(operand == rhs.operand))
      return false;
    return true;
  }
  bool operator != (const com_raytheon_uf_common_dataquery_requests_ConstraintType &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const com_raytheon_uf_common_dataquery_requests_ConstraintType & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _com_raytheon_uf_common_dataquery_requests_RequestConstraint__isset {
  _com_raytheon_uf_common_dataquery_requests_RequestConstraint__isset() : constraintType(false), constraintValue(false) {}
  bool constraintType;
  bool constraintValue;
} _com_raytheon_uf_common_dataquery_requests_RequestConstraint__isset;

class com_raytheon_uf_common_dataquery_requests_RequestConstraint {
 public:

  static const char* ascii_fingerprint; // = "BDAF55DAA660FA1ADBE30760752211A8";
  static const uint8_t binary_fingerprint[16]; // = {0xBD,0xAF,0x55,0xDA,0xA6,0x60,0xFA,0x1A,0xDB,0xE3,0x07,0x60,0x75,0x22,0x11,0xA8};

  com_raytheon_uf_common_dataquery_requests_RequestConstraint() : constraintValue("") {
  }

  virtual ~com_raytheon_uf_common_dataquery_requests_RequestConstraint() throw() {}

  com_raytheon_uf_common_dataquery_requests_ConstraintType constraintType;
  std::string constraintValue;

  _com_raytheon_uf_common_dataquery_requests_RequestConstraint__isset __isset;

  bool operator == (const com_raytheon_uf_common_dataquery_requests_RequestConstraint & rhs) const
  {
    if (!(constraintType == rhs.constraintType))
      return false;
    if (!(constraintValue == rhs.constraintValue))
      return false;
    return true;
  }
  bool operator != (const com_raytheon_uf_common_dataquery_requests_RequestConstraint &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const com_raytheon_uf_common_dataquery_requests_RequestConstraint & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _com_raytheon_uf_common_pointdata_PointDataServerRequest__isset {
  _com_raytheon_uf_common_pointdata_PointDataServerRequest__isset() : rcMap(false) {}
  bool rcMap;
} _com_raytheon_uf_common_pointdata_PointDataServerRequest__isset;

class com_raytheon_uf_common_pointdata_PointDataServerRequest {
 public:

  static const char* ascii_fingerprint; // = "C9F1CC9CD1A896EE01B7C5215E2BE99F";
  static const uint8_t binary_fingerprint[16]; // = {0xC9,0xF1,0xCC,0x9C,0xD1,0xA8,0x96,0xEE,0x01,0xB7,0xC5,0x21,0x5E,0x2B,0xE9,0x9F};

  com_raytheon_uf_common_pointdata_PointDataServerRequest() {
  }

  virtual ~com_raytheon_uf_common_pointdata_PointDataServerRequest() throw() {}

  std::map<std::string, com_raytheon_uf_common_dataquery_requests_RequestConstraint>  rcMap;

  _com_raytheon_uf_common_pointdata_PointDataServerRequest__isset __isset;

  bool operator == (const com_raytheon_uf_common_pointdata_PointDataServerRequest & rhs) const
  {
    if (!(rcMap == rhs.rcMap))
      return false;
    return true;
  }
  bool operator != (const com_raytheon_uf_common_pointdata_PointDataServerRequest &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const com_raytheon_uf_common_pointdata_PointDataServerRequest & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};



#endif
