#pragma once

#include "expat.h"
#include <cstring>
#include <iostream>
#include <ostream>
#include <string>
class ExpatParser {
public:
    ExpatParser(const char* buffer) : m_buffer(buffer) {
        XML_SetStartElementHandler(m_parser, StartElementHandler);
    }

    virtual ~ExpatParser() {
        XML_ParserFree(m_parser);
    }

    void parse() {
        std::cerr << "parse called on buffer: " << m_buffer << std::endl;
        XML_Parse(m_parser, m_buffer.data(), m_buffer.length(), true);
    }

    ExpatParser(const ExpatParser&) = delete;
    ExpatParser& operator=(const ExpatParser&) = delete;
private:
    static XMLCALL void StartElementHandler(void *userData, const XML_Char *name, const XML_Char **atts) {
        ((ExpatParser*) userData) -> onStartElement(name, atts);
    }

private:
    void onStartElement(const char* name, const char* attrs[]) {
        // TODO call user callback
        std::cerr << "onStartElement name=" << name << ", attrs=[" << "]" << std::endl;
    }

private:
    XML_Parser m_parser = XML_ParserCreate("UTF-8");
    std::string m_buffer;
};