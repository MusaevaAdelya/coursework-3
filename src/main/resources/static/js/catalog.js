const rangeInput = document.querySelectorAll(".range-input input"),
priceInput = document.querySelectorAll(".price-input input"),
    progress = document.querySelector(".slider .progress-filter");


let priceGap = 80;

priceInput.forEach(input =>{
    input.addEventListener("input" , e =>{
        let minVal = parseInt(priceInput[0].value),
            maxVal = parseInt(priceInput[1].value);

        if((maxVal - minVal >= priceGap) && maxVal <= 1000){
            if (e.target.className === "input-min" ){
                rangeInput[0].value = minVal ;
                if(minVal>0) {
                    progress.style.left = (minVal / rangeInput[0].max) * 100 + "%";
                }else{
                    progress.style.left = 0+"%";
                }
            }else {
                rangeInput[1].value = maxVal ;
                if(maxVal<1000) {
                    progress.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
                }else{
                    progress.style.right = 100 + "%";

                }
            }
        }



    })
});

rangeInput.forEach(input =>{
    input.addEventListener("input" , e =>{
        let minVal = parseInt(rangeInput[0].value),
            maxVal = parseInt(rangeInput[1].value);

        if(maxVal - minVal < priceGap){
            if (e.target.className === "range-min" ){
                rangeInput[0].value = maxVal - priceGap;
            }else {
                rangeInput[1].value = minVal + priceGap;
            }
        }else {
            priceInput[0].value = minVal;
            priceInput[1].value = maxVal;
            progress.style.left = (minVal / rangeInput[0].max) * 100 + "%";
            progress.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
        }



    })
});




const allStars = document.querySelectorAll(".star"),
currentRating = document.querySelector(".current-rating");
inputRating=document.getElementById("rating")


allStars.forEach((star , i) =>{
    star.onclick = function (){
        let current_star_level = i+1;

        allStars.forEach( (star , j) =>{
            if (current_star_level >= j+1){
                star.innerHTML = '&#9733';
                currentRating.innerText = `${current_star_level} of 5`
                inputRating.value=current_star_level
            }else {
                star.innerHTML = '&#9734';
            }
        })
    }
});