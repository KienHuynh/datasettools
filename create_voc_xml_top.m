function [top] = create_voc_xml_top(filename, author, im_w, im_h)
    
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
    '<name>';
    author;
    '</name>';
    '</owner>';
    '<size>';
    '<width>';
    int2str(im_w);
    '</width>';
    '<height>';
    int2str(im_h);
    '</height>';
    '<depth>3</depth>';
    '</size>';
    '<segmented>0</segmented>'};
end


