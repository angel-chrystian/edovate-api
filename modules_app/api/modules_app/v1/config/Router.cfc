component{

    function configure(){
        route( "companies/:id-numeric", "Companies.getCompany" );
        route( "/", "Companies.index" );

        route( "/:handler/:action" ).end();
    }

}