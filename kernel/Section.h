//
//  Header.h
//  kernel
//
//  Created by Tsukasa on 12-12-30.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#ifndef mqyy_kernel_Header_h
#define mqyy_kernel_Header_h
#include "BaseObj.h"
#include <string>


namespace mqyy {
namespace kernel{
    class Program;
    class Section
    : public BaseObj
    {
    public:
        Section(const char* szName, const Program* pProgram, const char* szPath);
        
        inline const char* GetName() const
        {
            return m_strName.c_str();
        }
        inline const char* GetPath() const
        {
            return m_strPath.c_str();
        }
    protected:
        ~Section();
        const Program* m_pProgram;
        std::string m_strName;
        std::string m_strPath;
    };
        
}
    
}



#endif
