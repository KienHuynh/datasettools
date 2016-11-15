function [ obj ] = create_voc_xml_object(type, xmin, ymin, xmax, ymax)
    obj = {'<object>';
    ['<name>' type '</name>'];
    '<pose>Unspecified</pose>';
    '<truncated>1</truncated>';
    '<difficult>0</difficult>';
    '<bndbox>';
    ['<xmin>' xmin '</xmin>'];
    ['<ymin>' ymin '</ymin>'];
    ['<xmax>' xmax '</xmax>'];
    ['<ymax>' ymax '</ymax>'];
    '</bndbox>';
    '</object>'};
end

