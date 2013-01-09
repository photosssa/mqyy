//
//  BaseObj.h
//  kernel
//
//  Created by Tsukasa on 12-12-30.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#ifndef mqyy_kernel_BaseObj_h
#define mqyy_kernel_BaseObj_h


namespace mqyy {
namespace kernel{
    class BaseObj{
    public:
        typedef const int RetType;
        static RetType RetSuccess = 0;
    public:
        unsigned long AddRef()
        {
            return ++m_ulRef;
        }
        unsigned long Release()
        {
            unsigned long ulResult = --m_ulRef;
            if (m_ulRef == 0) {
                delete this;
            }
            return ulResult;
        }
    protected:
        BaseObj()
        : m_ulRef(0)
        {
            
        }
        virtual ~BaseObj(){}
    private:
        unsigned long m_ulRef;
    };
}
}


#endif
