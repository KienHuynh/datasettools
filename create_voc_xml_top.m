function [top] = create_voc_xml_top(filename)
    
    top = {'<annotation>';
    '<folder>motorbike1</folder>';
    ['<filename>' filename '</filename>'];
    '<source>';
    '<database>yt</database>';
    '<annotation>PASCALVOC2007</annotation>';
    '<image>yt</image>';
    '<flickrid>none</flickrid>';
    '</source>';
    '<owner>';
    '<flickrid>none</flickrid>';
    '<name>Rob Whitworth</name>';
    '</owner>';
    '<size>';
    '<width>1280</width>';
    '<height>720</height>';
    '<depth>3</depth>';
    '</size>';
    '<segmented>0</segmented>'};
end


