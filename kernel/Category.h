//
//  Category.h
//  kernel
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#ifndef mqyy__kernel__Category__
#define mqyy__kernel__Category__

#include <iostream>
#include "Program.h"
#include <string.h>

namespace mqyy {
namespace kernel{
    class Category
    : public BaseObj
    {
    public:
        Category(const char* szName);
        const char* GetName() const
        {
            return m_strName.c_str();
        }
    protected:
        ~Category();
        std::string m_strName;
        
    };
}
}

#endif /* defined(mqyy__kernel__Category__) */
