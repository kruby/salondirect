module ViewerHelper
  
    def image
      if @image
  	    image_tag @image 
  	  end
	  end
	  
	  def pagetitle
	    "Velkommen til salondirect.dk"
    end
end
