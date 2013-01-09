//
//  Program.h
//  kernel
//
//  Created by Tsukasa on 12-12-30.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#ifndef mqyy_kernel_Program_h
#define mqyy_kernel_Program_h
#include "BaseObj.h"
#include <string>
#include <vector>
#include "Section.h"

namespace mqyy {
namespace kernel{
    class Program
    : public BaseObj
    {
    public:
        Program(const char*szName);
        
        inline const char* GetName() const
        {
            return m_strName.c_str();
        }
        RetType AddSection(const char* szName, const char*szPath);
        size_t GetSectionCount() const
        {
            return m_Sections.size();
        }
        Section* GetSectionByIndex(size_t nIndex) const
        {
            if(nIndex < GetSectionCount())
            {
                Section* pSection = m_Sections[nIndex];
                pSection->AddRef();
                return pSection;
            }
            return NULL;
        }
    protected:
        ~Program();
        std::string m_strName;
        typedef std::vector<Section*> Sections;
        Sections m_Sections;
    };
}
}

#endif
